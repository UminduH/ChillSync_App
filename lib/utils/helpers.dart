import 'package:flutter/material.dart';

class Helpers {
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