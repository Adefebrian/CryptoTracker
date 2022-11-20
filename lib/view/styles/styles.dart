import 'package:miniproject/view/constant/constant.dart';
import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primarySwatch: primarySwatch,
      primaryColor:
          isDarkTheme ? const Color.fromARGB(255, 31, 31, 31) : Colors.white,
      backgroundColor: isDarkTheme ? Colors.black : const Color(0xffF1F5FB),
      indicatorColor:
          isDarkTheme ? const Color(0xff0E1D36) : const Color(0xffCBDCF8),
      hintColor: isDarkTheme
          ? const Color.fromARGB(255, 255, 255, 255)
          : const Color(0xff280C0B),
      highlightColor: Colors.transparent,
      hoverColor: isDarkTheme ? const Color(0xff3A3A3B) : primaryColor,
      focusColor:
          isDarkTheme ? const Color(0xff0B2512) : const Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      cardColor: isDarkTheme ? const Color(0xFF151515) : Colors.grey[100],
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      colorScheme: ColorScheme.fromSwatch(
          primarySwatch: primarySwatch,
          accentColor: primaryColor,
          brightness: isDarkTheme ? Brightness.dark : Brightness.light),
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme
              ? const ColorScheme.dark()
              : const ColorScheme.light()),
      scaffoldBackgroundColor: isDarkTheme ? Colors.black : Colors.white,

      appBarTheme: AppBarTheme(
          foregroundColor: isDarkTheme ? Colors.white : Colors.black87,
          elevation: 0.0,
          centerTitle: false,
          backgroundColor: isDarkTheme ? Colors.black : Colors.white),
    );
  }
}
