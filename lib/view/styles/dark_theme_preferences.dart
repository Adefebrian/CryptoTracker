import 'package:get_storage/get_storage.dart';

class DarkThemePreference {
  // ignore: constant_identifier_names
  static const THEME_STATUS = "THEMESTATUS";
  final box = GetStorage();

  setDarkTheme(bool value) async {
    box.write(THEME_STATUS, value);
  }

  Future<bool> getTheme() async {
   return box.read(THEME_STATUS) ?? false;
  }
}
