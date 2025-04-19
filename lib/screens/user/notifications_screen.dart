import 'package:chillsync/components/custom_main_app_bar.dart';
import 'package:chillsync/models/notification_model.dart';
import 'package:chillsync/providers/notification_provider.dart';
import 'package:chillsync/providers/user_provider.dart';
import 'package:chillsync/utils/formatters.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notificationProvider = Provider.of<NotificationProvider>(context, listen: false);
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      if (userProvider.user != null) {
        notificationProvider.fetchNotifications(userProvider.user!.userId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomMainAppbar(title: 'Notifications', showLeading: false),
      backgroundColor: Colors.white,
      body: Consumer<NotificationProvider>(
        builder: (context, notificationProvider, child) {
          if (notificationProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (notificationProvider.notifications.isEmpty) {
            return const Center(child: Text('No new notifications.'));
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: notificationProvider.notifications.map((notification) {
                    return _buildNotificationCard(notification);
                  }).toList(),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildNotificationCard(NotificationModel notification) {
    return Card(
      color: Colors.grey[200],
      elevation: notification.isRead ? 1 : 5,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: notification.isRead ? Colors.transparent : Colors.blueAccent,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.alarm),
                const SizedBox(width: 5),
                Text(Formatters.formatTime(notification.timestamp)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  notification.type == NotificationType.alert
                    ? Icons.warning
                    : notification.type == NotificationType.info
                      ? Icons.info_outline
                      : Icons.notification_important,
                  color: notification.type == NotificationType.alert
                    ? Colors.red
                    : notification.type == NotificationType.info
                      ? Colors.blue
                      : Colors.orange,
                ),
                const SizedBox(width: 15),
                Text(
                  notification.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: notification.type == NotificationType.alert
                      ? Colors.red
                      : notification.type == NotificationType.info
                        ? Colors.blue
                        : Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(notification.message),
            const SizedBox(height: 15),
            if (!notification.isRead)
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Provider.of<NotificationProvider>(context, listen: false)
                      .markAsRead(notification.notificationId);
                  },
                  child: const Text('Mark as Read', style: TextStyle(color: Colors.blueAccent)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
