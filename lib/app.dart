// import 'package:chillsync/components/main_layout_screen.dart';
import 'package:chillsync/providers/notification_provider.dart';
import 'package:chillsync/providers/temperature_settings_provider.dart';
import 'package:chillsync/providers/user_provider.dart';
import 'package:chillsync/routes/app_routes.dart';
// import 'package:chillsync/screens/auth/enter_id_screen.dart';
// import 'package:chillsync/screens/user/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChillSync extends StatelessWidget {
  const ChillSync({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => TemperatureSettingsProvider()),
      ],
      child: MaterialApp(
        title: 'ChillSync',
        debugShowCheckedModeBanner: false,
        // home: MainLayoutScreen(),
        initialRoute: "/intro",
        routes: AppRoutes.routes,
      ),
    );
  }
}