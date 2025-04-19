import 'package:chillsync/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get user by device ID
  Future<UserModel?> getUserByDeviceId(String deviceId) async {
    try {
      DocumentSnapshot userDoc = await _db.collection("Users").doc(deviceId).get();
      if (!userDoc.exists) return null;

      return UserModel.fromJson(userDoc);
    } catch (e) {
      throw Exception("Failed to fetch user: $e");
    }
  }
}