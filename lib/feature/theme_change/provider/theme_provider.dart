import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = ChangeNotifierProvider((ref) => ThemeNotifier());

class ThemeNotifier extends ChangeNotifier {
  ThemeData _themeData = ThemeData.light();

  List<String> tempData = [];

  ThemeData get themeData => _themeData;

  void toggleDark() {
    _themeData = ThemeData.dark();
    log("toggleDark");
    notifyListeners();
  }

  void toggleLight() {
    _themeData = ThemeData.light();
    log("toggleLight");
    notifyListeners();
  }

  void updateCount() {
    for (var i = 0; i < 20; i++) {
      tempData.add("value $i");
    }
    notifyListeners();
  }
}
