import 'package:chillsync/models/sensor_data.dart';
import 'package:flutter/material.dart';

class TemperatureSettingsProvider extends ChangeNotifier {
  double _minTemperature = 4.0;
  double _maxTemperature = 10.0;
  double _minHumidity = 90;
  double _maxHumidity = 95;
  String? _selectedFoodType;

  bool tempOutOfRange = false;
  bool airQualityOutOfRange = false;
  bool humidityOutOfRange = false;
  bool doorOpen = false;

  SensorData? previousSensorData;

  double get minTemperature => _minTemperature;
  double get maxTemperature => _maxTemperature;
  double get minHumidity => _minHumidity;
  double get maxHumidity => _maxHumidity;
  String? get selectedFoodType => _selectedFoodType;

  void setMinTemperature(double value) {
    _minTemperature = value;
    notifyListeners();
  }

  void setMaxTemperature(double value) {
    _maxTemperature = value;
    notifyListeners();
  }

  void setMinHumidity(double value) {
    _minHumidity = value;
    notifyListeners();
  }

  void setMaxHumidity(double value) {
    _maxHumidity = value;
    notifyListeners();
  }

  void setSelectedFoodType(String? foodType) {
    _selectedFoodType = foodType;
    notifyListeners();
  }
}