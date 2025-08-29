import 'package:deprem_project/Models/Deprem.dart';
import 'package:deprem_project/pages/ayarlar_sayfasi.dart';
import 'package:deprem_project/pages/deprem_sayfasi.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          if (value == 0) {
            debugPrint("$value çalıştı");
          }

          if (value == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Ayarlar_Sayfasi()),
            );
          }
        },
        items: [
          BottomNavigationBarItem(label: "Deprem", icon: Icon(Icons.list_alt)),

          BottomNavigationBarItem(label: "Ayarlar", icon: Icon(Icons.settings)),

          BottomNavigationBarItem(label: "Harita", icon: Icon(Icons.map)),
        ],
      ),
      appBar: AppBar(
        title: Text("Deprem Demo Bitch"),
        backgroundColor: Colors.blue,
        actions: appBarPopUpMenu(),
      ),

      body: MyListWievBuilder(),
    );
  }
}

class MyListWievBuilder extends StatelessWidget {
  final List<int> items = List.generate(20, (index) => index);
  MyListWievBuilder({super.key});
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
      debugShowCheckedModeBanner: false,
      title: "Deprem Verileri",
      theme: ThemeData.dark(useMaterial3: true),
      home: Scaffold(
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapScreen(deprem: deprem),
                          ),
                        );
                      },
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

List<Widget> appBarPopUpMenu() {
  return ([
    PopupMenuButton(
      onSelected: (value) {
        if (value == "Bugun") {
          debugPrint("Bugün secildi");
        }

        if (value == "Bu_hafta") {
          debugPrint("Bu hafta secildi");
        }

        if (value == "Bu_ay") {
          debugPrint("Bu ay secildi");
        }

        if (value == "Bu_yil") {
          debugPrint("Bu yil secildi");
        }
      },
      icon: Icon(Icons.calendar_month),
      itemBuilder: (context) => [
        PopupMenuItem(value: "Bugun", child: Text("Bugün")),
        PopupMenuItem(value: "Bu_hafta", child: Text("Bu hafta")),
        PopupMenuItem(value: "Bu_ay", child: Text("Bu ay")),
        PopupMenuItem(value: "Bu_yil", child: Text("Bu yil")),
      ],
    ),

    PopupMenuButton(
      onSelected: (value) {
        if (value == "Bugun") {
          debugPrint("Bugün secildi");
        }

        if (value == "Bu_hafta") {
          debugPrint("Bu hafta secildi");
        }

        if (value == "Bu_ay") {
          debugPrint("Bu ay secildi");
        }

        if (value == "Bu_yil") {
          debugPrint("Bu yil secildi");
        }
      },
      icon: Icon(Icons.tune),
      itemBuilder: (context) => [
        PopupMenuItem(value: "En_yeni", child: Text("En yeni")),
        PopupMenuItem(value: "En_eski", child: Text("En eski")),
        PopupMenuItem(value: "En_buyuk", child: Text("En büyük")),
        PopupMenuItem(value: "En_kucuk", child: Text("En küçük")),
      ],
    ),
  ]);
}
