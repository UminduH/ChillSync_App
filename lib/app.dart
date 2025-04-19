import 'package:chillsync/providers/user_provider.dart';
import 'package:chillsync/routes/app_routes.dart';
import 'package:chillsync/screens/auth/enter_id_screen.dart';
// import 'package:chillsync/screens/user/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChillSync extends StatelessWidget {
  const ChillSync({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        title: 'ChillSync',
        debugShowCheckedModeBanner: false,
        home: EnterIdScreen(),
        routes: AppRoutes.routes,
      ),
    );
  }
}