import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static ThemeData buildTheme({
    required Brightness brightness,
    required String themeScheme,
    required String? fontFamily,
    required double fontSizeDelta,
  }) {
    Color seedColor;
    ColorScheme? customColorScheme;

    switch (themeScheme) {
      case 'softIndiglow':
        seedColor = const Color(0xFF5C6BC0);
        if (brightness == Brightness.dark) {
          customColorScheme = ColorScheme.fromSeed(
            seedColor: seedColor,
            brightness: brightness,
            surface: const Color(0xFF1E1E2C),
          );
        } else {
          customColorScheme = ColorScheme.fromSeed(
            seedColor: seedColor,
            brightness: brightness,
            surface: const Color(0xFFF8F9FF),
          );
        }
        break;
      case 'modernIndigo':
        seedColor = const Color(0xFF4F46E5);
        if (brightness == Brightness.dark) {
          customColorScheme = ColorScheme.fromSeed(
            seedColor: seedColor,
            brightness: brightness,
            surface: const Color(0xFF1E1B2E),
          );
        } else {
          customColorScheme = ColorScheme.fromSeed(
            seedColor: seedColor,
            brightness: brightness,
            surface: const Color(0xFFF7F8FA),
          );
        }
        break;
      case 'quietSage':
        seedColor = const Color(0xFF0E7C66);
        if (brightness == Brightness.dark) {
          customColorScheme = ColorScheme.fromSeed(
            seedColor: seedColor,
            brightness: brightness,
            surface: const Color(0xFF1F2A26),
          );
        } else {
          customColorScheme = ColorScheme.fromSeed(
            seedColor: seedColor,
            brightness: brightness,
            surface: const Color(0xFFF8F9F6),
          );
        }
        break;
      case 'onyx':
        seedColor = const Color(0xFF5FD0C5);
        if (brightness == Brightness.dark) {
          customColorScheme = ColorScheme.fromSeed(
            seedColor: seedColor,
            brightness: brightness,
            surface: const Color(0xFF15171C),
          );
        } else {
          customColorScheme = ColorScheme.fromSeed(
            seedColor: seedColor,
            brightness: brightness,
            surface: const Color(0xFFF4F5F7), // Neutral light equivalent
          );
        }
        break;
      case 'ocean':
        seedColor = const Color(0xFF0EA5E9);
        if (brightness == Brightness.dark) {
          customColorScheme = ColorScheme.fromSeed(
            seedColor: seedColor,
            brightness: brightness,
            surface: const Color(0xFF09111C),
          );
        } else {
          customColorScheme = ColorScheme.fromSeed(
            seedColor: seedColor,
            brightness: brightness,
            surface: const Color(0xFFF0F6FA), // Light blue-tinted equivalent
          );
        }
        break;
      case 'default':
      default:
        seedColor = brightness == Brightness.light
            ? const Color(0xFF6750A4)
            : const Color(0xFFD0BCFF);
        break;
    }

    final colorScheme = customColorScheme ??
        ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: brightness,
        );

    final typography = Typography.material2021(
      platform: defaultTargetPlatform,
    );
    final colorTextTheme = brightness == Brightness.light
        ? typography.black
        : typography.white;

    var textTheme = typography.englishLike
        .apply(fontSizeDelta: fontSizeDelta)
        .merge(colorTextTheme);

    final String? actualFontFamily =
        (fontFamily == null || fontFamily == 'System Default')
            ? null
            : fontFamily;

    if (actualFontFamily != null) {
      textTheme = GoogleFonts.getTextTheme(actualFontFamily, textTheme);
    }

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      textTheme: textTheme,
    );
  }
}
