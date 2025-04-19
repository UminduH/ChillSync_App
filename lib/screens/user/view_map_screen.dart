import 'package:chillsync/models/sensor_data.dart';
import 'package:chillsync/services/sensor_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ViewMapScreen extends StatefulWidget {
  const ViewMapScreen({super.key});

  @override
  State<ViewMapScreen> createState() => _ViewMapScreenState();
}

class _ViewMapScreenState extends State<ViewMapScreen> {
  final SensorService _sensorService = SensorService();
  LatLng? _deviceLocation;
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Location'),
      ),
      body: StreamBuilder<SensorData?>(
        stream: _sensorService.getLatestSensorDataStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final sensorData = snapshot.data!;
            _deviceLocation = LatLng(sensorData.latitude, sensorData.longitude);

            if (_deviceLocation != null) {
              Future.delayed(Duration.zero, () {
                _mapController.move(_deviceLocation!, 15.0);
              });
            }

            return FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: const LatLng(0, 0),
                initialZoom: 2.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.chillsync',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: _deviceLocation ?? const LatLng(0, 0),
                      child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
                    ),
                  ],
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading map: ${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}