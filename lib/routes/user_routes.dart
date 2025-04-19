import 'package:chillsync/components/main_layout_screen.dart';
import 'package:chillsync/screens/user/control_temperature.dart';
import 'package:chillsync/screens/user/home_screen.dart';
import 'package:chillsync/screens/user/notifications_screen.dart';
import 'package:chillsync/screens/user/user_account.dart';
import 'package:chillsync/screens/user/view_map_screen.dart';
import 'package:flutter/material.dart';

class UserRoutes{
  static Map<String, WidgetBuilder> routes = {
    '/main-layout-screen': (context) => MainLayoutScreen(),
    '/home': (context) => HomeScreen(),
    '/view-map': (context) => ViewMapScreen(),
    '/notifications': (context) => NotificationScreen(),
    '/user-profile': (context) => UserAccountScreen(),
    '/control-temperature': (context) => ControlTemperature(),
  };
}