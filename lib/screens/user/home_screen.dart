import 'package:chillsync/models/sensor_data.dart';
import 'package:chillsync/providers/user_provider.dart';
import 'package:chillsync/services/sensor_service.dart';
import 'package:chillsync/utils/formatters.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SensorService _sensorService = SensorService();

  String _getAirQualityStatus(double ppm) {
    if (ppm < 50) {
      return 'Excellent';
    } else if (ppm < 100) {
      return 'Good';
    } else if (ppm < 150) {
      return 'Moderate';
    } else if (ppm < 200) {
      return 'Poor';
    } else {
      return 'Very Poor';
    }
  }

  String _getTemperatureStatus(double temperature) {
    if (temperature < 10) {
      return 'Very Cold';
    } else if (temperature < 20) {
      return 'Cold';
    } else if (temperature < 28) {
      return 'Comfortable';
    } else if (temperature < 35) {
      return 'Warm';
    } else {
      return 'Hot';
    }
  }

  String _getHumidityStatus(double humidity) {
    if (humidity < 30) {
      return 'Very Dry';
    } else if (humidity < 40) {
      return 'Dry';
    } else if (humidity < 60) {
      return 'Comfortable';
    } else if (humidity < 70) {
      return 'Slightly Humid';
    } else {
      return 'Very Humid';
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      return Column(
                        children: [
                          _progressCard(
                            'Current Temperature',
                            sensorData.temperature,
                            50,
                            '°C',
                            _getTemperatureStatus(sensorData.temperature),
                            Icons.thermostat,
                          ),
                          const SizedBox(height: 20),
                          _progressCard(
                            'Current Humidity',
                            sensorData.humidity,
                            100,
                            '% RH',
                            _getHumidityStatus(sensorData.humidity),
                            Icons.water_drop,
                          ),
                          const SizedBox(height: 20),
                          _progressCard(
                            'Air Quality',
                            sensorData.airQuality,
                            500,
                            'PPM',
                            _getAirQualityStatus(sensorData.airQuality),
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
                    _buildQuickAccessButton(context, 'Set temperature', Icons.thermostat, '/control-temperature'),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
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