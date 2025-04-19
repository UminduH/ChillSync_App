import 'package:chillsync/screens/auth/enter_id_screen.dart';
import 'package:chillsync/screens/auth/signup.dart';
import 'package:chillsync/screens/auth/enter_otp_screen.dart';
import 'package:flutter/material.dart';

class AuthRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/enter-id': (context) => EnterIdScreen(),
    '/enter-otp': (context) => EnterOtpScreen(),
    '/signup': (context) => SignUpScreen(),
  };
}