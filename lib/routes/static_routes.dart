import 'package:chillsync/screens/static/about_us.dart';
import 'package:chillsync/screens/static/privacy_policy.dart';
import 'package:flutter/material.dart';

class StaticRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/about-us': (context) => AboutUsScreen(),
    '/privacy-policy': (context) => PrivacyPolicyScreen(),
  };
}