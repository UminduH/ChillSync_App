import 'dart:math';
import 'package:flutter/material.dart';

class Helpers {
  static String generateOtp() {
    Random random = Random();
    int otp = 100000 + random.nextInt(900000);
    return otp.toString();
  }

  static void debugPrintWithBorder(String message) {
    print("========================================");
    print(message);
    print("========================================");
  }

  static void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message),
    ));
  }
}