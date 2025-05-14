import 'package:chillsync/models/notification_model.dart';
import 'package:chillsync/services/notification_service.dart';
import 'package:chillsync/utils/helpers.dart';
import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationService _notificationService = NotificationService();
  List<NotificationModel> _notifications = [];
  int _notificationCount = 0;
  bool _isLoading = false;

  final newNotificationNotifier = ValueNotifier<bool>(false);

  List<NotificationModel> get notifications => _notifications;
  int get notificationCount => _notificationCount;
  bool get isLoading => _isLoading;

  // Method to clear the new notification flag
  void clearNewNotificationFlag() {
    newNotificationNotifier.value = false;
  }

  // Fetch user notifications
  Future<void> fetchNotifications(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _notifications = await _notificationService.getUserNotifications(userId);
      _notificationCount = _notifications.where((notif) => !notif.isRead).length;
    } catch (e) {
      Helpers.debugPrintWithBorder("Error fetching user notifications: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  // Create a notification
  Future<void> createNotification(NotificationModel notification, String userId) async {
    try {
      await _notificationService.createNotification(notification, userId);

      newNotificationNotifier.value = true;
      Future.delayed(const Duration(milliseconds: 500), () {
        newNotificationNotifier.value = false;
      });

      fetchNotifications(notification.driverId);
    } catch (e) { 
      Helpers.debugPrintWithBorder("Error creating notification: $e");
      notifyListeners();
    }
  }

  // Mark notification as read
  Future<void> markAsRead(String notificationId) async {
    try {
      await _notificationService.markAsRead(notificationId);
      final index = _notifications.indexWhere((notif) => notif.notificationId == notificationId);
      if (index != -1) {
        _notifications[index].isRead = true;
      }
      _notificationCount = _notifications.where((notif) => !notif.isRead).length;

      notifyListeners();

    } catch (e) {
      Helpers.debugPrintWithBorder("Error marking notification as read: $e");
      notifyListeners();
    }
  }
}