  import 'package:deprem_project/Models/Deprem.dart';
import 'package:dio/dio.dart';

Future<List<Deprem>> getDeprems() async {
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