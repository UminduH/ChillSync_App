import 'package:chillsync/screens/user/home_screen.dart';
import 'package:chillsync/screens/user/notifications_screen.dart';
import 'package:chillsync/screens/user/user_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainLayoutScreen extends StatefulWidget {

  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _screens;
  late final List<BottomNavigationBarItem> _navItems;

  @override
  void initState() {
    super.initState();

    _screens = [
        HomeScreen(),
        NotificationScreen(),
        UserAccountScreen()
      ];

      _navItems = [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Notifications"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
      ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent, 
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  
    return PopScope(
      canPop: _selectedIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          if (_selectedIndex != 0) {
            setState(() {
              _selectedIndex = 0;
            });
          } 
        }
      },
      child: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey.shade200, width: 1),
            ),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: Colors.blueAccent,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: _navItems,
          ),
        ),
      ),
    );
  }
}