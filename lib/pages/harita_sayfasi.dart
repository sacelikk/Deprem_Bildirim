import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../Models/Deprem.dart';
import '../servers/getdeprems.dart';
import '../servers/depremrenk.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<Deprem> _depremler = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadDepremler();
  }

  Future<void> _loadDepremler() async {
    final list = await getDeprems();
    
    setState(() {
      _depremler = list;
      _loading = false;
    });
    
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(39.0, 35.0), // Türkiye
        initialZoom: 6,
      ),
      children: [
        // 🗺️ Harita
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.deprem_project',
        ),

        // 📍 TÜM DEPREM MARKERLARI
        MarkerLayer(
          markers: _depremler.map((deprem) {
            return Marker(
              point: LatLng(deprem.latitude, deprem.longitude),
              width: 40,
              height: 40,
              child: Icon(
                Icons.location_on,
                color: depremRenk(deprem.mag),
                size: deprem.mag >= 5 ? 40 : 30,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}