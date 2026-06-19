import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import '../../app/audio_providers.dart';

class AudioPlayerWidget extends ConsumerStatefulWidget {
  const AudioPlayerWidget({super.key});

  @override
  ConsumerState<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends ConsumerState<AudioPlayerWidget> {
  final AudioPlayer _player = AudioPlayer();
  String? _currentUrl;

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _loadAudio(String url) async {
    if (_currentUrl == url) return;
    _currentUrl = url;
    try {
      await _player.setUrl(url);
    } catch (e) {
      debugPrint('Error loading audio: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final audioData = ref.watch(chapterAudioProvider);

    if (audioData == null) {
      _player.stop();
      _currentUrl = null;
      return const SizedBox.shrink();
    }

    _loadAudio(audioData.url);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        constraints: const BoxConstraints(maxWidth: 400),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Voice Actor Dropdown
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: audioData.activeVoice,
                icon: const Icon(Icons.arrow_drop_down, size: 20),
                style: Theme.of(context).textTheme.bodySmall,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    ref.read(selectedVoiceProvider.notifier).setVoice(newValue);
                  }
                },
                items: audioData.availableVoices.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(width: 8),

            // Play / Pause Button
            StreamBuilder<PlayerState>(
              stream: _player.playerStateStream,
              builder: (context, snapshot) {
                final playerState = snapshot.data;
                final processingState = playerState?.processingState;
                final playing = playerState?.playing;
                
                if (processingState == ProcessingState.loading ||
                    processingState == ProcessingState.buffering) {
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    width: 32.0,
                    height: 32.0,
                    child: const CircularProgressIndicator(),
                  );
                } else if (playing != true) {
                  return IconButton(
                    icon: const Icon(Icons.play_arrow),
                    iconSize: 32.0,
                    onPressed: _player.play,
                  );
                } else if (processingState != ProcessingState.completed) {
                  return IconButton(
                    icon: const Icon(Icons.pause),
                    iconSize: 32.0,
                    onPressed: _player.pause,
                  );
                } else {
                  return IconButton(
                    icon: const Icon(Icons.replay),
                    iconSize: 32.0,
                    onPressed: () => _player.seek(Duration.zero),
                  );
                }
              },
            ),

            // Seek Bar
            Expanded(
              child: StreamBuilder<Duration>(
                stream: _player.positionStream,
                builder: (context, snapshot) {
                  final position = snapshot.data ?? Duration.zero;
                  final duration = _player.duration ?? Duration.zero;
                  
                  return Slider(
                    value: position.inMilliseconds.toDouble(),
                    max: duration.inMilliseconds.toDouble() > 0 ? duration.inMilliseconds.toDouble() : 1.0,
                    onChanged: (value) {
                      _player.seek(Duration(milliseconds: value.round()));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
