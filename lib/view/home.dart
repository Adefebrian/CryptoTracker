import 'package:miniproject/view/screens/home/home_screen.dart';
import 'package:miniproject/view/screens/profile/profile_screen.dart';
import 'package:miniproject/view/screens/settings/settings_screen.dart';
import 'package:miniproject/view/screens/watchlist/watchlist_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onSelectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _listPage = const [
    HomeScreen(),
    WatchlistScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            onTap: _onSelectPage,
            currentIndex: _selectedIndex,
            type: BottomNavigationBarType.fixed,
            // selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: "Watchlist",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Settings",
              ),
            ]),
        body: IndexedStack(
          index: _selectedIndex,
          children: _listPage,
        ));
  }
}
