import 'package:chillsync/routes/app_routes.dart';
import 'package:chillsync/screens/auth/enter_id_screen.dart';
import 'package:flutter/material.dart';

class ChillSync extends StatelessWidget {
  const ChillSync({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChillSync',
      debugShowCheckedModeBanner: false,
      home: EnterIdScreen(),
      routes: AppRoutes.routes,
    );
  }
}