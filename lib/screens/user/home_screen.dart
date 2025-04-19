import 'package:chillsync/models/sensor_data.dart';
import 'package:chillsync/services/sensor_service.dart';
import 'package:chillsync/utils/formatters.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SensorService _sensorService = SensorService();

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
                const Text(
                  "Hello , @Username",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
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
                            100,
                            '°C',
                            'Temperature status',
                          ),
                          const SizedBox(height: 20),
                          _progressCard(
                            'Current Humidity',
                            sensorData.humidity,
                            100,
                            '% RH',
                            'Humidity status',
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return const CircularProgressIndicator();
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

  Widget _progressCard(String title, double value, double totalValue, String unit, String status) {
    return Container(
      width: double.infinity,
      height: 200,
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
            Text(
              title,
              style: const TextStyle(
                fontSize: 27,
                color: Colors.white,
              ),
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
                const SizedBox(
                  height: 5,
                ),
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
                Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Icon(icon, size: 50, color: Colors.blue[700]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}