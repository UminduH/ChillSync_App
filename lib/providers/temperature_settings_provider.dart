import 'package:chillsync/models/sensor_data.dart';
import 'package:flutter/material.dart';

class TemperatureSettingsProvider extends ChangeNotifier {
  double _minTemperature = 15.0;
  double _maxTemperature = 35.0;
  String? _selectedFoodType;

  bool tempOutOfRange = false;
  bool airQualityOutOfRange = false;
  bool humidityOutOfRange = false;
  bool doorOpen = false;

  SensorData? previousSensorData;

  double get minTemperature => _minTemperature;
  double get maxTemperature => _maxTemperature;
  String? get selectedFoodType => _selectedFoodType;

  void setMinTemperature(double value) {
    _minTemperature = value;
    notifyListeners();
  }

  void setMaxTemperature(double value) {
    _maxTemperature = value;
    notifyListeners();
  }

  void setSelectedFoodType(String? foodType) {
    _selectedFoodType = foodType;
    notifyListeners();
  }
}