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
      appBar: AppBar(title: Text("Deprem")),
      body: Stack(
        children: [
          MapWidget(deprem: deprem), // Harita

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: Theme.of(context).brightness == Brightness.dark
                    ? const Color.fromARGB(255, 236, 231, 231)
                    : const Color.fromARGB(255, 223, 4, 19),
              ),
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.dark
                              ? const Color.fromARGB(255, 232, 227, 227)
                              : const Color.fromARGB(255, 116, 1, 1),
                          child: Text(
                            "${deprem.mag} ",
                            style: const TextStyle(fontSize: 20),
                            selectionColor: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            deprem.title,
                            maxLines: 1, // 👈 uzun yazı taşmaz
                            overflow: TextOverflow.ellipsis,
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
                              deprem.date.split(" ")[0],
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
                            _buildInfoBlock(
                              Icons.language,
                              deprem.longitude.toString(),
                              "Boylam",
                            ),
                            _buildInfoBlock(
                              Icons.language,
                              deprem.latitude.toString(),
                              "Enlem",
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildInfoBlock(
                              Icons.route,
                              "638.04",
                              "Mesafe (km)",
                            ),
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
            maxLines: 1, // 👈 taşma engeli
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class MapWidget extends StatelessWidget {
  final Deprem deprem;

  const MapWidget({super.key, required this.deprem});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(deprem.latitude, deprem.longitude),
        initialZoom: 6.5,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.deprem_project',
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: LatLng(deprem.latitude, deprem.longitude),
              child: const Icon(
                Icons.location_pin,
                color: Colors.red,
                size: 40,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
