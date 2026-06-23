import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

/// Thin wrapper over the platform text-to-speech engine.
///
/// `flutter_tts` supports Android, iOS, macOS, Windows and Web but **not**
/// Linux. [isSupported] reflects that so the UI can hide the read-aloud control
/// where no engine is available, rather than offering a button that does
/// nothing.
class TtsService {
  TtsService() {
    if (isSupported) {
      // Resolve `speak()` only once the utterance actually finishes, so callers
      // can read a chapter verse-by-verse with a plain `await` loop.
      _tts.awaitSpeakCompletion(true);
    }
  }

  final FlutterTts _tts = FlutterTts();

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

  /// Speak [text]. With `awaitSpeakCompletion(true)` the returned future
  /// completes when the utterance finishes (or is stopped).
  Future<void> speak(String text) => _tts.speak(text);

  Future<void> stop() => _tts.stop();

  /// Set the speech rate from a familiar playback multiplier (1.0 = normal).
  ///
  /// `flutter_tts` takes a normalized 0.0–1.0 rate where ~0.5 reads at a natural
  /// pace on most engines, so we map `multiplier` onto that, anchoring 1.0× to
  /// 0.5 and clamping to the engine's valid range.
  Future<void> setRate(double multiplier) =>
      _tts.setSpeechRate((0.5 * multiplier).clamp(0.0, 1.0));
}
