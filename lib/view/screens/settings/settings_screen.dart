import 'package:miniproject/view/constant/constant.dart';
import 'package:miniproject/viewmodels/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                Text(
                  "Settings",
                  style: titleStyleHeader,
                ),
              ],
            ),
          ),
          SwitchListTile(
              activeColor: primaryColor,
              activeTrackColor: primaryColor.withOpacity(0.5),
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey[400],
              title: const Text("Dark Mode"),
              value: themeProvider.darkTheme,
              onChanged: themeProvider.setDarkTheme),
       
        ],
      ),
    );
  }
}
