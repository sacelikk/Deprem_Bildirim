import 'dart:ui';
import 'package:deprem_project/pages/ayarlar_sayfasi.dart';
import 'package:deprem_project/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'pages/harita_sayfasi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<MyListWievBuilderState> listKey =
      GlobalKey<MyListWievBuilderState>();

  int _currentIndex = 0;

  late final List<Widget> _pages = [
    MyListWievBuilder(key: listKey),
    const MapScreen(),
    const AyarlarSayfasi(),
  ];

  String get _title {
    switch (_currentIndex) {
      case 0:
        return "Son Depremler";
      case 1:
        return "Deprem Haritası";
      case 2:
        return "Ayarlar";
      default:
        return "Deprem Uyarı";
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "Roboto",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: Scaffold(
        extendBody: true,

        /// 🌈 GRADIENT APPBAR
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFB31217), Color(0xFFE52D27)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: Text(
            _title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
        ),

        /// 🔄 SADECE DEPREMLERDE REFRESH
        floatingActionButton: _currentIndex == 0
            ? FloatingActionButton(
                backgroundColor: Colors.redAccent,
                onPressed: () {
                  listKey.currentState?.refresh();
                },
                child: const Icon(Icons.refresh),
              )
            : null,

        /// 🧈 YUMUŞAK GEÇİŞ
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: IndexedStack(
            key: ValueKey(_currentIndex),
            index: _currentIndex,
            children: _pages,
          ),
        ),

        /// 💎 GLASSMORPHISM NAVBAR
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: NavigationBar(
              height: 72,
              backgroundColor: Colors.white.withOpacity(0.75),
              indicatorColor: Colors.red.withOpacity(0.15),
              selectedIndex: _currentIndex,
              onDestinationSelected: (index) {
                setState(() => _currentIndex = index);
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.list_alt_outlined),
                  selectedIcon: Icon(Icons.list_alt),
                  label: "Depremler",
                ),
                NavigationDestination(
                  icon: Icon(Icons.map_outlined),
                  selectedIcon: Icon(Icons.map),
                  label: "Haritaa",
                ),
                NavigationDestination(
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings),
                  label: "Ayarlar",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}