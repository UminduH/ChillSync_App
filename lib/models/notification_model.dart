import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String notificationId;
  final String deviceId;
  final String driverId;
  final String title;
  final String message;
  final DateTime timestamp;
  final NotificationType type;
  bool isRead;

  NotificationModel({
    required this.notificationId,
    required this.deviceId,
    required this.driverId,
    required this.title,
    required this.message,
    required this.timestamp,
    this.type = NotificationType.alert,
    this.isRead = false,
  });

  factory NotificationModel.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return NotificationModel(
      notificationId: doc.id,
      deviceId: data['device_id'] ?? '',
      driverId: data['driver_id'] ?? '',
      type: _getNotificationType(data['type']),
      title: data['title'] ?? '',
      message: data['message'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      isRead: data['is_read'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "device_id": deviceId,
      "driver_id": driverId,
      "type": type.name,
      "title": title,
      "message": message,
      "timestamp": Timestamp.fromDate(timestamp),
      "is_read": isRead,
    };
  }

  static NotificationType _getNotificationType(String type) {
    switch (type) {
      case "alert":
        return NotificationType.alert;
      case "info":
        return NotificationType.info;
      case "warning":
        return NotificationType.warning;
      default:
        return NotificationType.general;
    }
  }
}

enum NotificationType { alert, info, warning, general }
