  import 'package:flutter/material.dart';

Color depremRenk(double mag) {
    if (mag < 3.0) {
      return Colors.lightGreen; // çok küçük
    } else if (mag < 4.0) {
      return Colors.green; // hafif
    } else if (mag < 5.0) {
      return Colors.yellow; // orta
    } else if (mag < 6.0) {
      return Colors.orange; // hissedilir
    } else if (mag < 7.0) {
      return Colors.red; // güçlü
    } else if (mag < 8.0) {
      return Colors.purple; // çok güçlü
    } else {
      return Colors.black; // yıkıcı
    }
  }