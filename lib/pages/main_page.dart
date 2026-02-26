import 'package:deprem_project/Models/Deprem.dart';
import 'package:deprem_project/pages/ayarlar_sayfasi.dart';
import 'package:deprem_project/pages/deprem_detay_sayfasi.dart';
import 'package:deprem_project/servers/depremrenk.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:deprem_project/servers/getdeprems.dart';
class MyListWievBuilder extends StatefulWidget {
  const MyListWievBuilder({super.key});

  @override
  State<MyListWievBuilder> createState() => MyListWievBuilderState();
}

class MyListWievBuilderState extends State<MyListWievBuilder> {
 
  late Future<List<Deprem>> _futureDepremler;
  @override
  void initState() {
    super.initState();
    _futureDepremler = getDeprems();
  }

  void refresh() {
    setState(() {
      _futureDepremler = getDeprems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Deprem>>(
      
      future: _futureDepremler,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Hata: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("Deprem verisi bulunamadı"));
        } else {
          final depremler = snapshot.data!;
         return ListView.builder(
  padding: const EdgeInsets.only(top: 8, bottom: 16),
  itemCount: depremler.length,
  itemBuilder: (context, index) {
    final deprem = depremler[index];

    return Padding(
      
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Material(
        borderRadius: BorderRadius.circular(16),
        elevation: 3,
        color: Theme.of(context).cardColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MapScreen(deprem: deprem),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                // 🔴 MAGNİTÜD BADGE
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: depremRenk(deprem.mag),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    deprem.mag.toStringAsFixed(1),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                // 📄 DEPREM BİLGİLERİ
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        deprem.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),

                      Row(
                        children: [
                          const Icon(Icons.layers, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            "${deprem.depth} km",
                            style: const TextStyle(fontSize: 13),
                          ),
                          const SizedBox(width: 12),
                          const Icon(Icons.schedule, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            deprem.date,
                            style: const TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // ➡️ OK
                const Icon(
                  Icons.chevron_right,
                  size: 28,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  },
);
        }
      },
    );
  }
}
