import 'package:chillsync/components/main_layout_screen.dart';
import 'package:chillsync/screens/user/control_temperature.dart';
import 'package:chillsync/screens/user/view_map_screen.dart';
import 'package:flutter/material.dart';

class UserRoutes{
  static Map<String, WidgetBuilder> routes = {
    '/home': (context) => MainLayoutScreen(selectedIndex: 0),
    '/notifications': (context) => MainLayoutScreen(selectedIndex: 1),
    '/user-profile': (context) => MainLayoutScreen(selectedIndex: 2),
    '/view-map': (context) => ViewMapScreen(),
    '/control-temperature': (context) => ControlTemperature(),
  };
}