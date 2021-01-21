import 'package:flutter/material.dart';

class PrimaryPallete {
  static const MaterialColor mainPallete =
      MaterialColor(_mainPalletePrimaryValue, <int, Color>{
    50: Color(0xFFEDFDFF),
    100: Color(0xFFD3FAFF),
    200: Color(0xFFB6F6FF),
    300: Color(0xFF98F2FE),
    400: Color(0xFF82F0FE),
    500: Color(_mainPalletePrimaryValue),
    600: Color(0xFF64EBFE),
    700: Color(0xFF59E8FE),
    800: Color(0xFF4FE5FE),
    900: Color(0xFF3DE0FD),
  });
  static const int _mainPalletePrimaryValue = 0xFF6CEDFE;

  static const MaterialColor mainPalleteAccent =
      MaterialColor(_mainPalleteAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_mainPalleteAccentValue),
    400: Color(0xFFE4FBFF),
    700: Color(0xFFCAF7FF),
  });
  static const int _mainPalleteAccentValue = 0xFFFFFFFF;
}
