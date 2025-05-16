import 'dart:convert';
import 'package:chillsync/models/sensor_data.dart';
import 'package:chillsync/services/sensor_service.dart';
import 'package:chillsync/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class ViewMapScreen extends StatefulWidget {
  const ViewMapScreen({super.key});

  @override
  State<ViewMapScreen> createState() => _ViewMapScreenState();
}

class _ViewMapScreenState extends State<ViewMapScreen> {
  final SensorService _sensorService = SensorService();
  final MapController _mapController = MapController();
  final Distance _distance = const Distance();

  final LatLng _destination = const LatLng(6.8213, 80.0416);  // Sample fixed location (NSBM Green University)

  LatLng? _deviceLocation;
  LatLng? _lastFetchedLocation;

  List<LatLng> _routePoints = [];
  bool _isFetchingRoute = false;

  Future<void> _fetchRoute(LatLng start, LatLng end) async {
    setState(() {
      _isFetchingRoute = true;
    });

    try {
      final url = Uri.parse(
          'https://router.project-osrm.org/route/v1/driving/${start.longitude},${start.latitude};${end.longitude},${end.latitude}?overview=full&geometries=geojson');

      final response = await http.get(url, headers: {
        'User-Agent': 'chillsync-app'
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final coords = data['routes'][0]['geometry']['coordinates'] as List;

        setState(() {
          _routePoints = coords
              .map((c) => LatLng(c[1], c[0])) // [lon, lat] -> LatLng(lat, lon)
              .toList();
        });
      } else {
        Helpers.debugPrintWithBorder("Failed to get route: ${response.body}");
      }
    } catch (e) {
      Helpers.debugPrintWithBorder("Error fetching route: $e");
    } finally {
      setState(() {
        _isFetchingRoute = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('View Location')),
      body: StreamBuilder<SensorData?>(
        stream: _sensorService.getLatestSensorDataStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final sensorData = snapshot.data!;
            _deviceLocation = LatLng(sensorData.latitude, sensorData.longitude);

            if (_deviceLocation != null) {
              Future.delayed(Duration.zero, () {
                _mapController.move(_deviceLocation!, 13.0);
              });

              // Only fetch route if location changed significantly
              final movedFar = _lastFetchedLocation == null ||
                  _distance(_lastFetchedLocation!, _deviceLocation!) > 50;

              if (movedFar && !_isFetchingRoute) {
                _lastFetchedLocation = _deviceLocation;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _fetchRoute(_deviceLocation!, _destination);
                });
              }
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
                    if (_deviceLocation != null)
                      Marker(
                        width: 40,
                        height: 40,
                        point: _deviceLocation!,
                        child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
                      ),
                    Marker(
                      width: 40,
                      height: 40,
                      point: _destination,
                      child: const Icon(Icons.flag, color: Colors.green, size: 40),
                    ),
                  ],
                ),
                if (_routePoints.isNotEmpty)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: _routePoints,
                        strokeWidth: 5.0,
                        color: Colors.blue,
                      ),
                    ],
                  ),
              ],
            );
          } else if (snapshot.hasError) {
            Helpers.debugPrintWithBorder("Error loading map: ${snapshot.error}");
            return Center(child: Text('An error occurred while loading the map.'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}