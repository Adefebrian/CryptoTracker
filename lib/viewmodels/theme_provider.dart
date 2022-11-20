
import 'package:miniproject/view/styles/dark_theme_preferences.dart';
import 'package:flutter/foundation.dart';

class ThemeProvider extends ChangeNotifier {
  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool darkTheme = false;
  
  ThemeProvider() {
    darkThemePreference.getTheme().then((value) {
      darkTheme = value;
      notifyListeners();
    });
  }

  void setDarkTheme(bool value) {
    darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }
}
