import 'package:deprem_project/pages/ayarlar_sayfasi.dart';
import 'package:deprem_project/pages/deprem_sayfasi.dart';

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

          if (value == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MapScreen()),
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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        int value = items[index];
        return Card(
          child: Container(
            height: 100,
            child: Center(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MapScreen()),
                  );
                  debugPrint("iceriğe basildi");
                },
                title: Text(value.toString(), style: TextStyle(fontSize: 25)),
                subtitle: Text("sub title"),
                leading: CircleAvatar(
                  radius: 30,

                  backgroundColor: value > 5
                      ? Colors.red.shade200
                      : Colors.green.shade200,
                  child: Text(
                    value.toString(),
                    style: TextStyle(
                      color: value > 5
                          ? Colors.red.shade900
                          : Colors.green.shade900,
                    ),
                  ),
                ),
                trailing: Icon(size: 30, Icons.arrow_forward_ios),
              ),
            ),
          ),
        );
      },
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
