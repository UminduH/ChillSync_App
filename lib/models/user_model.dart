import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId;  // Driver ID
  final String deviceId;
  final String vehicleNo;
  final String name;
  final String phone;
  final DateTime registeredAt;

  UserModel({
    required this.userId,
    required this.deviceId,
    required this.vehicleNo,
    required this.name,
    required this.phone,
    required this.registeredAt,
  });

  factory UserModel.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return UserModel(
      userId: data['driver_id'] ?? '',
      deviceId: data['device_id'] ?? 'CSYNC0001',
      vehicleNo: data['vehicle_number'] ?? '',
      name: data['driver_name'] ?? '',
      phone: data['contact_number'] ?? '',
      registeredAt: (data['registered_at'] as Timestamp).toDate(),
    );
  }
}