import 'package:deprem_project/Models/Deprem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  final Deprem deprem;

  const MapScreen({super.key, required this.deprem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const MapWidget(), // Harita

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: Colors.lightBlue,
              ),
              padding: const EdgeInsets.all(2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(child: Text("${deprem.mag}")),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          deprem.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildInfoBlock(
                            Icons.date_range,
                            deprem.date,
                            "Tarih",
                          ),
                          _buildInfoBlock(
                            Icons.access_time,
                            deprem.date.contains(" ")
                                ? deprem.date.split(" ")[1]
                                : "-",
                            "Saat",
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildInfoBlock(Icons.language, "39.7946", "Boylam"),
                          _buildInfoBlock(Icons.language, "39.1318", "Enlem"),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildInfoBlock(Icons.route, "638.04", "Mesafe (km)"),
                          _buildInfoBlock(
                            Icons.arrow_circle_down_rounded,
                            "${deprem.depth}",
                            "Derinlik(km)",
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBlock(IconData icon, String label, String sub) {
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            sub,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class MapWidget extends StatelessWidget {
  const MapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(41.0082, 28.9784),
        initialZoom: 11.0,
      ),

      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.deprem_project',
        ),
      ],
    );
  }
}
