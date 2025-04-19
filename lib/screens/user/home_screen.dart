import 'package:chillsync/models/notification_model.dart';
import 'package:chillsync/models/sensor_data.dart';
import 'package:chillsync/providers/notification_provider.dart';
import 'package:chillsync/providers/temperature_settings_provider.dart';
import 'package:chillsync/providers/user_provider.dart';
import 'package:chillsync/services/sensor_service.dart';
import 'package:chillsync/utils/formatters.dart';
import 'package:chillsync/utils/sensor_status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SensorService _sensorService = SensorService();
  bool _isShowingNotificationPopup = false;

  final double _maxAirQuality = 250.0;
  final String _doorStatusOpen = 'Open';

  void _checkSensorDataAndNotify(BuildContext context, SensorData sensorData) {
    final notificationProvider = Provider.of<NotificationProvider>(context, listen: false);
    final temperatureSettings = Provider.of<TemperatureSettingsProvider>(context, listen: false);
    final userId = Provider.of<UserProvider>(context, listen: false).user?.userId ?? '';
    final deviceId = "CSYNC0001";

    // Temperature check
    if (sensorData.temperature < temperatureSettings.minTemperature ||
        sensorData.temperature > temperatureSettings.maxTemperature) {
      if (!temperatureSettings.tempOutOfRange) {
        notificationProvider.createNotification(
          NotificationModel(
            notificationId: DateTime.now().millisecondsSinceEpoch.toString(),
            deviceId: deviceId,
            driverId: userId,
            title: 'Temperature Alert!',
            message: 'The current temperature (${sensorData.temperature}°C) is outside the acceptable range (${temperatureSettings.minTemperature}°C - ${temperatureSettings.maxTemperature}°C).',
            timestamp: DateTime.now(),
            type: NotificationType.alert,
          ),
        );
        temperatureSettings.tempOutOfRange = true;
      }
    } else {
      temperatureSettings.tempOutOfRange = false;
    }

    // Air Quality check
    if (sensorData.airQuality > _maxAirQuality) {
      if (!temperatureSettings.airQualityOutOfRange) {
        notificationProvider.createNotification(
          NotificationModel(
            notificationId: DateTime.now().millisecondsSinceEpoch.toString(),
            deviceId: deviceId,
            driverId: userId,
            title: 'Air Quality Warning!',
            message: 'The current air quality (${sensorData.airQuality} PPM) exceeds the acceptable limit ($_maxAirQuality PPM).',
            timestamp: DateTime.now(),
            type: NotificationType.warning,
          ),
        );
        temperatureSettings.airQualityOutOfRange = true;
      }
    } else {
      temperatureSettings.airQualityOutOfRange = false;
    }

    // Humidity check
    if (sensorData.humidity < temperatureSettings.minHumidity || sensorData.humidity > temperatureSettings.maxHumidity) {
      if (!temperatureSettings.humidityOutOfRange) {
        notificationProvider.createNotification(
          NotificationModel(
            notificationId: DateTime.now().millisecondsSinceEpoch.toString(),
            deviceId: deviceId,
            driverId: userId,
            title: 'Humidity Alert!',
            message: 'The current humidity (${sensorData.humidity}% RH) is outside the acceptable range (${temperatureSettings.minHumidity}% RH - ${temperatureSettings.maxHumidity}% RH).',
            timestamp: DateTime.now(),
            type: NotificationType.alert,
          ),
        );
        temperatureSettings.humidityOutOfRange = true;
      }
    } else {
      temperatureSettings.humidityOutOfRange = false;
    }

    // Door Status check
    if (sensorData.doorStatus.toLowerCase() == _doorStatusOpen.toLowerCase()) {
      if (!temperatureSettings.doorOpen) {
        notificationProvider.createNotification(
          NotificationModel(
            notificationId: DateTime.now().millisecondsSinceEpoch.toString(),
            deviceId: deviceId,
            driverId: userId,
            title: 'Door Alert!',
            message: 'The vehicle door is currently open.',
            timestamp: DateTime.now(),
            type: NotificationType.warning,
          ),
        );
        temperatureSettings.doorOpen = true;
      }
    } else {
      temperatureSettings.doorOpen = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final temperatureSettings = Provider.of<TemperatureSettingsProvider>(context, listen: false);

    return Consumer<NotificationProvider>(
      builder: (context, notificationProvider, child) {
        return ValueListenableBuilder<bool>(
          valueListenable: notificationProvider.newNotificationNotifier,
          builder: (context, hasNewNotification, _) {
            // Show a pop-up if there's a new notification
            if (hasNewNotification && !_isShowingNotificationPopup) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _showNewNotificationPopup(context);
                _isShowingNotificationPopup = true;
              });
            }

            return Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${Formatters.formatDate(DateTime.now())} ${Formatters.formatDay(DateTime.now())}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        Consumer<UserProvider>(
                          builder: (context, userProvider, child) {
                            return Text(
                              "Hello, ${userProvider.user!.name}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        StreamBuilder<SensorData?>(
                          stream: _sensorService.getLatestSensorDataStream(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final sensorData = snapshot.data!;
            
                              final previousSensorData = temperatureSettings.previousSensorData;
                              if (previousSensorData == null ||
                                  previousSensorData.accelX != sensorData.accelX ||
                                  previousSensorData.accelY != sensorData.accelY ||
                                  previousSensorData.accelZ != sensorData.accelZ ||
                                  previousSensorData.airQuality != sensorData.airQuality ||
                                  previousSensorData.doorStatus != sensorData.doorStatus ||
                                  previousSensorData.humidity != sensorData.humidity ||
                                  previousSensorData.latitude != sensorData.latitude ||
                                  previousSensorData.longitude != sensorData.longitude ||
                                  previousSensorData.temperature != sensorData.temperature ||
                                  previousSensorData.timestamp != sensorData.timestamp) {
                                // The sensor data has changed
                                temperatureSettings.tempOutOfRange = false;
                                temperatureSettings.humidityOutOfRange = false;
                                temperatureSettings.airQualityOutOfRange = false;
                                temperatureSettings.doorOpen = false;
            
                                _checkSensorDataAndNotify(context, sensorData);
            
                                // Update the previous sensor data
                                temperatureSettings.previousSensorData = sensorData;
                              }
            
                              return Column(
                                children: [
                                  _progressCard(
                                    'Current Temperature',
                                    sensorData.temperature,
                                    50,
                                    '°C',
                                    SensorStatus.getTemperatureStatus(sensorData.temperature),
                                    Icons.thermostat,
                                  ),
                                  const SizedBox(height: 20),
                                  _progressCard(
                                    'Current Humidity',
                                    sensorData.humidity,
                                    100,
                                    '% RH',
                                    SensorStatus.getHumidityStatus(sensorData.humidity),
                                    Icons.water_drop,
                                  ),
                                  const SizedBox(height: 20),
                                  _progressCard(
                                    'Air Quality',
                                    sensorData.airQuality,
                                    500,
                                    'PPM',
                                    SensorStatus.getAirQualityStatus(sensorData.airQuality),
                                    Icons.air,
                                  ),
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return Center(child: Text('Error: ${snapshot.error}'));
                            } else {
                              return const Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Quick Access",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildQuickAccessButton(context, 'View Map', Icons.map, '/view-map'),
                            const SizedBox(width: 20),
                            _buildQuickAccessButton(context, 'Set Temperature', Icons.thermostat, '/control-temperature'),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        );
      },
    );
  }

  Future<void> _showNewNotificationPopup(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('New Notification!'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You have a new notification in the Notifications tab.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _isShowingNotificationPopup = false;
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/notifications');
              },
              child: const Text('View Notifications', style: TextStyle(color: Colors.blueAccent)),
            ),
            TextButton(
              onPressed: () {
                _isShowingNotificationPopup = false;
                Navigator.of(context).pop();
              },
              child: const Text('Dismiss', style: TextStyle(color: Colors.redAccent)),
            ),
          ],
        );
      },
    );
  }

  Widget _progressCard(String title, double value, double totalValue, String unit, String status, IconData icon) {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0099FF), Color(0xFF0147FC)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.white, size: 30),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 27,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${value.toStringAsFixed(2)} $unit',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  status,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            //progress bar
            LinearProgressIndicator(
              value: value / totalValue,
              backgroundColor: const Color(0xFF0147FC),
              valueColor: const AlwaysStoppedAnimation(Colors.white),
              minHeight: 15,
              borderRadius: BorderRadius.circular(100),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccessButton(BuildContext context, String label, IconData icon, String route) {
    return SizedBox(
      height: 150,
      width: 150,
      child: Card(
        color: Colors.grey[100],
        child: InkWell(
          onTap: () => Navigator.pushNamed(context, route),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 50, color: Colors.blue[700]),
                const SizedBox(height: 8),
                Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}