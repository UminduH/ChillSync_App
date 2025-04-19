import 'package:chillsync/utils/helpers.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/sensor_data.dart';

class SensorService {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref().child('CSYNC0001');

  Future<SensorData?> fetchLatestSensorData() async {
    try {
      DataSnapshot snapshot = await _databaseReference
          .orderByKey()
          .limitToLast(1)
          .get();

      if (snapshot.value != null) {
        final dynamic rawData = snapshot.value;
        if (rawData is Map) {
          final dynamic latestRawData = rawData.values.first;
          if (latestRawData is Map<Object?, Object?>) {
            Map<String, dynamic> latestData = {};
            latestRawData.forEach((key, value) {
              latestData[key.toString()] = value;
            });
            return SensorData.fromJson(latestData);
          }
        }
      }
      return null;
    } catch (error) {
      Helpers.debugPrintWithBorder("Error fetching data: $error");
      return null;
    }
  }

  Stream<SensorData?> getLatestSensorDataStream() {
    return _databaseReference
        .orderByKey()
        .limitToLast(1)
        .onValue
        .map((event) {
      if (event.snapshot.value != null) {
        final dynamic rawData = event.snapshot.value;
        if (rawData is Map) {
          final dynamic latestRawData = rawData.values.first;
          if (latestRawData is Map<Object?, Object?>) {
            Map<String, dynamic> latestData = {};
            latestRawData.forEach((key, value) {
              latestData[key.toString()] = value;
            });
            return SensorData.fromJson(latestData);
          }
        }
      }
      return null;
    });
  }
}