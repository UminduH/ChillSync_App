class SensorData {
  final double accelX;
  final double accelY;
  final double accelZ;
  final double airQuality;
  final String doorStatus;
  final double humidity;
  final double latitude;
  final double longitude;
  final double temperature;
  final String timestamp;

  SensorData({
    required this.accelX,
    required this.accelY,
    required this.accelZ,
    required this.airQuality,
    required this.doorStatus,
    required this.humidity,
    required this.latitude,
    required this.longitude,
    required this.temperature,
    required this.timestamp,
  });

  factory SensorData.fromJson(Map<String, dynamic> json) {
    return SensorData(
      accelX: double.tryParse(json['accelX']?.toString() ?? '0.04') ?? 0.04,
      accelY: double.tryParse(json['accelY']?.toString() ?? '0.39') ?? 0.39,
      accelZ: double.tryParse(json['accelZ']?.toString() ?? '11.30') ?? 11.30,
      airQuality: double.tryParse(json['airQuality']?.toString() ?? '186') ?? 186,
      doorStatus: json['doorStatus']?.toString() ?? 'Closed',
      humidity: double.tryParse(json['humidity']?.toString() ?? '64.40') ?? 64.40,
      latitude: double.tryParse(json['latitude']?.toString() ?? '6.806010') ?? 6.806010,
      longitude: double.tryParse(json['longitude']?.toString() ?? '79.935808') ?? 79.935808,
      temperature: double.tryParse(json['temperature']?.toString() ?? '32.44') ?? 32.44,
      timestamp: json['timestamp']?.toString() ?? '',
    );
  }
}