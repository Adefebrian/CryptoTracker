import 'package:miniproject/viewmodels/asset_provider.dart';
import 'package:miniproject/viewmodels/auth_provider.dart';
import 'package:miniproject/viewmodels/detail_asset_provider.dart';
import 'package:miniproject/viewmodels/watchlist_provider.dart';
import 'package:miniproject/viewmodels/theme_provider.dart';
import 'package:miniproject/view/home.dart';
import 'package:miniproject/view/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'view/styles/styles.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => AssetsProvider()),
      ChangeNotifierProvider(create: (_) => DetailAssetProvider()),
      ChangeNotifierProvider(create: (_) => WatchlistProvider())
    ], child: const MyApp()));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, theme, _) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
          statusBarBrightness:
              theme.darkTheme ? Brightness.dark : Brightness.light));
      return Consumer<AuthProvider>(builder: (context, auth, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Crypto Tracker',
          theme: Styles.themeData(theme.darkTheme, context),
          // home: const HomePage(),
          home: auth.account.email != null ? const HomePage() : LoginScreen(),
        );
      });
    });
  }
}
