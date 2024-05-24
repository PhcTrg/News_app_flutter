import 'package:flutter/material.dart';
import '../core/app_export.dart';

LightCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

/// Helper class for managing themes and colors.
// ignore_for_file: must_be_immutable

class ThemeHelper {
  // The current app theme
  var _appTheme = PrefUtils().getThemeData();

// A map of custom color themes supported by the app
  Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors()
  };

// A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme
  };

  /// Returns the lightCode colors for the current theme.
  LightCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      scaffoldBackgroundColor: appTheme.whiteA700,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: appTheme.indigoA40001,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadowColor: appTheme.blueA2000f.withOpacity(0.51),
          elevation: 4,
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: 3,
        space: 3,
        color: appTheme.blueGray400.withOpacity(0.26),
      ),
    );
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

/// Class containing the supported text theme styles.
class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyLarge: TextStyle(
          color: appTheme.blueGray900,
          fontSize: 18.fSize,
          fontFamily: 'Abel',
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          color: appTheme.blueGray900,
          fontSize: 14.fSize,
          fontFamily: 'Abel',
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          color: appTheme.indigoA40001,
          fontSize: 12.fSize,
          fontFamily: 'Abel',
          fontWeight: FontWeight.w400,
        ),
        headlineSmall: TextStyle(
          color: appTheme.blueGray900,
          fontSize: 24.fSize,
          fontFamily: 'Abel',
          fontWeight: FontWeight.w400,
        ),
        titleLarge: TextStyle(
          color: appTheme.whiteA700,
          fontSize: 20.fSize,
          fontFamily: 'Abel',
          fontWeight: FontWeight.w400,
        ),
      );
}

/// Class containing the supported color schemes.
class ColorSchemes {
  static final lightCodeColorScheme = ColorScheme.light();
}

/// Class containing custom colors for a lightCode theme.
class LightCodeColors {
  // Black
  Color get black900 => Color(0XFF000000);
  Color get black90026 => Color(0X26000000);
// Blue
  Color get blue400 => Color(0XFF48AFE2);
  Color get blue800 => Color(0XFF2151CD);
  Color get blueGray60019 => Color(0X194F5B79);
// BlueAf
  Color get blueA2000f => Color(0X0F5182FF);
// BlueGray
  Color get blueGray200 => Color(0XFFBBC6D6);
  Color get blueGray400 => Color(0XFF7B8BB2);
  Color get blueGray40001 => Color(0XFF888888);
  Color get blueGray900 => Color(0XFF0D253C);
  Color get blueGray90070 => Color(0X700C243C);
// Cyan
  Color get cyan100 => Color(0XFF9CECFB);
// Gray
  Color get gray50 => Color(0XFFFAFBFF);
  Color get gray300 => Color(0XFFD9DFEA);
  Color get gray5000 => Color(0X00F9FAFF);
  Color get gray5001 => Color(0XFFF8F8F8);
  Color get gray5002 => Color(0XFFF4F7FF);
// Indigo
  Color get indigo800 => Color(0XFF2D4379);
  Color get indigoA400 => Color(0XFF386BED);
  Color get indigoA40001 => Color(0XFF376AED);
// White
  Color get whiteA700 => Color(0XFFFFFFFF);
}
