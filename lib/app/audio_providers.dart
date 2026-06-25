import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import '../data/logging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/audio_bible.dart';
import 'app_state.dart';
import 'dashboard_providers.dart';
import 'reader_state.dart';
import 'content_providers.dart';
import 'shared_prefs.dart';

// 1. Load all available audio bibles
final audioBiblesProvider = FutureProvider<List<AudioBible>>((ref) async {
  final files = {
    'bsb': 'assets/media/bsb-audio.json',
    'kjv': 'assets/media/kjv-audio.json',
  };

  final List<AudioBible> bibles = [];

  for (final entry in files.entries) {
    try {
      final jsonString = await rootBundle.loadString(entry.value);
      final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
      bibles.add(AudioBible.fromJson(entry.key, jsonData));
    } catch (e, stack) {
      logError(e, stack, context: 'loadAudioBibles: ${entry.key}');
    }
  }

  return bibles;
});

// 2. User selected voice actor
class SelectedVoiceNotifier extends Notifier<String?> {
  @override
  String? build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getString('selectedVoice');
  }

  void setVoice(String voice) {
    state = voice;
    ref.read(sharedPreferencesProvider).setString('selectedVoice', voice);
  }
}

final selectedVoiceProvider = NotifierProvider<SelectedVoiceNotifier, String?>(
  () => SelectedVoiceNotifier(),
);

// 4. Current chapter audio data (URL + available voices)
class ChapterAudioData {
  final String url;
  final List<String> availableVoices;
  final String activeVoice;

  ChapterAudioData({
    required this.url,
    required this.availableVoices,
    required this.activeVoice,
  });
}

final chapterAudioProvider = Provider<ChapterAudioData?>((ref) {
  final activeVersions = ref.watch(activeVersionsProvider);
  if (activeVersions.isEmpty) return null;

  final versions = ref.watch(versionsProvider.select((v) => v.value));
  final bibles = ref.watch(audioBiblesProvider.select((v) => v.value));

  if (versions == null || bibles == null) {
    return null; // Equivalent to loading
  }

  final activeId = activeVersions.first;
  final activeBibleVersion = versions
      .where((v) => v.id == activeId)
      .firstOrNull;

  if (activeBibleVersion == null) return null;

  final name = activeBibleVersion.name.toLowerCase();
  final abbrev = activeBibleVersion.abbreviation.toLowerCase();
  final id = activeBibleVersion.id.toLowerCase();

  AudioBible? activeBible;

  // Check for KJV matches
  if (name.contains('kjv') ||
      name.contains('king james') ||
      abbrev.contains('kjv') ||
      id.contains('kjv')) {
    activeBible = bibles.where((b) => b.name == 'kjv').firstOrNull;
  }

  // Check for BSB matches
  if (activeBible == null &&
      (name.contains('bsb') ||
      name.contains('berean') ||
      abbrev.contains('bsb') ||
      id.contains('bsb'))) {
    activeBible = bibles.where((b) => b.name == 'bsb').firstOrNull;
  }

  if (activeBible == null) return null;

  final bookName = ref.watch(selectedBookNameProvider);
  final chapter = ref.watch(selectedChapterProvider);

  final audioMap = activeBible.getAudioForChapter(bookName, chapter);
  if (audioMap == null || audioMap.isEmpty) return null;

  final availableVoices = audioMap.keys.toList()..sort();
  String? selectedVoice = ref.watch(selectedVoiceProvider);

  // If user hasn't selected a voice, or the selected voice isn't available for this chapter, pick the first one
  if (selectedVoice == null || !availableVoices.contains(selectedVoice)) {
    // We don't want to update the provider state during build, so we just use a default
    // We prefer 'gilbert' or 'souer' if available
    if (availableVoices.contains('gilbert')) {
      selectedVoice = 'gilbert';
    } else if (availableVoices.contains('souer')) {
      selectedVoice = 'souer';
    } else {
      selectedVoice = availableVoices.first;
    }
  }

  return ChapterAudioData(
    url: audioMap[selectedVoice]!,
    availableVoices: availableVoices,
    activeVoice: selectedVoice,
  );
});

// 5. Long-lived audio playback controller.
//
// The [AudioPlayer] lives here — in a kept-alive provider — rather than inside
// the audio bottom-sheet widget, so dismissing the sheet does NOT stop
// playback. The sheet is just a view onto this controller. The controller also
// reactively (re)loads audio whenever the active chapter/voice changes, which
// keeps auto-advance working even while the sheet is closed.

/// Immutable view-state for the audio player UI. Player position/playing state
/// is read from the [AudioPlayer]'s own streams, not from here.
class AudioPlayerUiState {
  final bool loadFailed;
  final double playbackSpeed;
  final int? sleepMinutes; // active sleep-timer duration, null when off

  const AudioPlayerUiState({
    this.loadFailed = false,
    this.playbackSpeed = 1.0,
    this.sleepMinutes,
  });

  AudioPlayerUiState copyWith({
    bool? loadFailed,
    double? playbackSpeed,
    int? sleepMinutes,
    bool clearSleep = false,
  }) {
    return AudioPlayerUiState(
      loadFailed: loadFailed ?? this.loadFailed,
      playbackSpeed: playbackSpeed ?? this.playbackSpeed,
      sleepMinutes: clearSleep ? null : (sleepMinutes ?? this.sleepMinutes),
    );
  }
}

class AudioPlayerController extends Notifier<AudioPlayerUiState> {
  late final AudioPlayer player;
  String? _currentUrl;
  bool _shouldAutoPlay = false;
  bool _disposed = false;
  Timer? _sleepTimer;
  StreamSubscription? _playerStateSubscription;

  static const List<double> speedOptions = [0.75, 1.0, 1.25, 1.5, 2.0];
  static const List<int> sleepOptions = [15, 30, 45, 60];

  @override
  AudioPlayerUiState build() {
    // Keep the player alive even when no widget is watching this provider, so
    // closing the audio bottom sheet doesn't tear playback down.
    ref.keepAlive();

    player = AudioPlayer();
    _playerStateSubscription = player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        _onChapterComplete();
      }
    });

    // React to chapter/voice changes without rebuilding (which would recreate
    // the player). fireImmediately loads the current chapter's audio.
    ref.listen<ChapterAudioData?>(
      chapterAudioProvider,
      (_, next) => _onAudioDataChanged(next),
      fireImmediately: true,
    );

    ref.onDispose(() {
      _disposed = true;
      _playerStateSubscription?.cancel();
      _sleepTimer?.cancel();
      player.dispose();
    });

    return const AudioPlayerUiState();
  }

  void _onAudioDataChanged(ChapterAudioData? data) {
    if (data == null) {
      player.stop();
      _currentUrl = null;
      if (state.loadFailed) state = state.copyWith(loadFailed: false);
      return;
    }
    _loadAudio(data.url);
  }

  Future<void> _loadAudio(String url) async {
    if (_currentUrl == url) return;
    _currentUrl = url;
    try {
      await player.setUrl(url);
      if (_disposed) return;
      await player.setSpeed(state.playbackSpeed);
      if (_disposed) return;
      if (_shouldAutoPlay) {
        _shouldAutoPlay = false;
        player.play();
      }
      if (state.loadFailed) state = state.copyWith(loadFailed: false);
    } catch (e, stack) {
      logError(e, stack, context: 'AudioPlayerController._loadAudio');
      _shouldAutoPlay = false;
      if (!_disposed) state = state.copyWith(loadFailed: true);
    }
  }

  Future<void> retryLoad() async {
    final url = _currentUrl;
    if (url == null) return;
    _currentUrl = null; // force _loadAudio to re-attempt the same url
    _shouldAutoPlay = true;
    await _loadAudio(url);
  }

  Future<void> _onChapterComplete() async {
    _shouldAutoPlay = true;

    final book = ref.read(selectedBookNameProvider);
    final chapter = ref.read(selectedChapterProvider);

    // Mark the just-finished chapter read on completion, if enabled. This
    // runs before nextChapter() and independently of whether navigation
    // actually advances, so the final chapter of the Bible (which has no
    // next chapter to move to) is still credited.
    if (ref.read(audioAdvanceMarksReadProvider)) {
      ref
          .read(dashboardActionProvider)
          .markChapterRead(book, chapter)
          .catchError((Object e) => debugPrint('Failed to mark read: $e'));
    }

    await ref.read(navigationControllerProvider).nextChapter();

    // If nothing advanced (e.g. the final chapter of the Bible), clear the
    // pending auto-play so it doesn't linger and surprise the next load.
    if (_disposed) return;
    if (ref.read(selectedBookNameProvider) == book &&
        ref.read(selectedChapterProvider) == chapter) {
      _shouldAutoPlay = false;
    }
  }

  /// Move to an adjacent chapter from the player, preserving playback: if audio
  /// is currently playing, the next chapter auto-plays once loaded.
  void skipChapter({required bool forward}) {
    _shouldAutoPlay = player.playing;
    final nav = ref.read(navigationControllerProvider);
    if (forward) {
      nav.nextChapter();
    } else {
      nav.previousChapter();
    }
  }

  void cycleSpeed() {
    final i = speedOptions.indexOf(state.playbackSpeed);
    final next = speedOptions[(i + 1) % speedOptions.length];
    state = state.copyWith(playbackSpeed: next);
    player.setSpeed(next);
  }

  void setSleepTimer(int? minutes) {
    _sleepTimer?.cancel();
    if (minutes == null) {
      state = state.copyWith(clearSleep: true);
      return;
    }
    state = state.copyWith(sleepMinutes: minutes);
    _sleepTimer = Timer(Duration(minutes: minutes), () {
      player.pause();
      if (!_disposed) state = state.copyWith(clearSleep: true);
    });
  }
}

final audioPlayerControllerProvider =
    NotifierProvider<AudioPlayerController, AudioPlayerUiState>(
      () => AudioPlayerController(),
    );
