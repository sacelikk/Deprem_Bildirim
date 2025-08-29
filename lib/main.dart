import 'package:deprem_project/Models/Deprem.dart';
import 'package:deprem_project/pages/deprems.dart';
import 'package:deprem_project/pages/harita_sayfasi.dart';
import 'package:deprem_project/pages/main_page.dart';

import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MapScreen());
  }
}
