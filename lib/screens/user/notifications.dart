import 'package:chillsync/components/custom_main_app_bar.dart';
import 'package:chillsync/utils/formatters.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomMainAppbar(title: 'Notifications', showLeading: false),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [_buildNotificationcard("The vehicle door has been left open. Ensure your vehicle is secure to avoid potential risks!")],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationcard(String notificationMessage) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.alarm),
                SizedBox(width: 5),
                Text(Formatters.formatTime(DateTime.now())),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.warning, color: Colors.red),
                SizedBox(width: 15),
                Text(
                  'Warning',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Text(notificationMessage),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
