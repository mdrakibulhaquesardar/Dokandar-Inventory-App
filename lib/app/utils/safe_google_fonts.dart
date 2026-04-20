import 'package:flutter/material.dart';

/// Custom font helper that uses local fonts (Roboto and NotoSansBengali)
/// Replaces GoogleFonts with local font files
class SafeGoogleFonts {
  /// Get Poppins-like font (using Roboto as replacement)
  static TextStyle poppins({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      decoration: decoration,
    );
  }

  /// Get Noto Sans Bengali font (using local NotoSansBengali font)
  static TextStyle notoSansBengali({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: 'NotoSansBengali',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      decoration: decoration,
    );
  }
}
