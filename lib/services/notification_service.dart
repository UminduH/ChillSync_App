import 'package:chillsync/models/notification_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create a notification
  Future<void> createNotification(NotificationModel notification) async {
    try {
      await _db.collection("Notifications").doc(notification.notificationId).set(notification.toJson());
    } catch (e) {
      throw Exception("Failed to create notification: $e");
    }
  }

  // Mark a notification as read
  Future<void> markAsRead(String notificationId) async {
    await _db.collection("Notifications").doc(notificationId).update({"is_read": true});
  }

  // Get a notification by ID
  Future<NotificationModel?> getNotificationById(String notificationId) async {
    DocumentSnapshot doc = await _db.collection("Notifications").doc(notificationId).get();
    if (!doc.exists) return null;

    return NotificationModel.fromJson(doc);  
  }

  // Get all unread notifications for a user
  Future<List<NotificationModel>> getUserNotifications(String userId) async {
    QuerySnapshot snapshot = await _db
      .collection("Notifications")
      .where('driver_id', isEqualTo: userId)
      .where('is_read', isEqualTo: false)
      .orderBy('timestamp', descending: true)
      .get();

    return snapshot.docs.map((doc) => NotificationModel.fromJson(doc)).toList();
  }
}
