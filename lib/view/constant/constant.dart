import 'package:flutter/material.dart';

const Color primaryColor = Color(0xff1164fe);

Map<int, Color> color = {
  50: primaryColor,
  100: primaryColor,
  200: primaryColor,
  300: primaryColor,
  400: primaryColor,
  500: primaryColor,
  600: primaryColor,
  700: primaryColor,
  800: primaryColor,
  900: primaryColor,
};

MaterialColor primarySwatch = MaterialColor(0xff1164fe, color);

TextStyle get titleStyleHeader =>
    const TextStyle(fontWeight: FontWeight.bold, fontSize: 28);
TextStyle get titleStyleText =>
    const TextStyle(fontWeight: FontWeight.w700, fontSize: 16);
