import 'package:chillsync/screens/static/about_us.dart';
import 'package:chillsync/screens/static/privacy_policy.dart';
import 'package:chillsync/screens/static/splash_screen.dart';
import 'package:flutter/material.dart';

class StaticRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/intro': (context) => SplashScreen(),
    '/about-us': (context) => AboutUsScreen(),
    '/privacy-policy': (context) => PrivacyPolicyScreen(),
  };
}