import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

/// Thin wrapper over the platform text-to-speech engine.
///
/// `flutter_tts` supports Android, iOS, macOS, Windows and Web but **not**
/// Linux. [isSupported] reflects that so the UI can hide the read-aloud control
/// where no engine is available, rather than offering a button that does
/// nothing.
///
/// All engine calls are guarded so they degrade to no-ops when the platform
/// channel is unavailable (e.g. in widget tests), instead of throwing
/// `MissingPluginException`.
class TtsService {
  final FlutterTts _tts = FlutterTts();
  bool _initialized = false;

  /// Whether a TTS engine is available on the current platform.
  static bool get isSupported {
    if (kIsWeb) return true;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return true;
      default: // Linux, Fuchsia
        return false;
    }
  }

  /// Resolve `speak()` only once the utterance actually finishes, so callers can
  /// read a chapter verse-by-verse with a plain `await` loop. Done lazily on
  /// first use rather than in the constructor so merely constructing the service
  /// (which Riverpod may do eagerly) never touches the platform channel.
  Future<void> _ensureInit() async {
    if (_initialized) return;
    _initialized = true;
    await _tts.awaitSpeakCompletion(true);
  }

  /// Speak [text]. The returned future completes when the utterance finishes
  /// (or is stopped).
  Future<void> speak(String text) async {
    try {
      await _ensureInit();
      await _tts.speak(text);
    } catch (_) {
      // No engine on this platform / channel — treat as a silent no-op.
    }
  }

  Future<void> stop() async {
    try {
      await _tts.stop();
    } catch (_) {}
  }

  /// Set the speech rate from a familiar playback multiplier (1.0 = normal).
  ///
  /// `flutter_tts` takes a normalized 0.0–1.0 rate where ~0.5 reads at a natural
  /// pace on most engines, so we map `multiplier` onto that, anchoring 1.0× to
  /// 0.5 and clamping to the engine's valid range.
  Future<void> setRate(double multiplier) async {
    try {
      await _tts.setSpeechRate((0.5 * multiplier).clamp(0.0, 1.0));
    } catch (_) {}
  }
}
