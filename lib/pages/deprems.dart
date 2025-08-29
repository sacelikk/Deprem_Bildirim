import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../Models/Deprem.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  Future<List<Deprem>> _getDeprems() async {
    final dio = Dio();
    var url = "https://api.orhanaydogdu.com.tr/deprem/kandilli/live";
    var response = await dio.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data["result"];
      return data.map((e) => Deprem.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Deprem Verileri",
      theme: ThemeData.dark(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text("Son Depremler"), centerTitle: true),
        body: FutureBuilder<List<Deprem>>(
          future: _getDeprems(),
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
                itemCount: depremler.length,
                itemBuilder: (context, index) {
                  final deprem = depremler[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: deprem.mag >= 5
                            ? Colors.red
                            : Colors.orange,
                        child: Text(
                          deprem.mag.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(deprem.title),
                      subtitle: Text(
                        "Derinlik: ${deprem.depth} km\nTarih: ${deprem.date}",
                      ),
                      isThreeLine: true,
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
