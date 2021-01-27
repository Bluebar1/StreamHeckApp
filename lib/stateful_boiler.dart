import 'package:flutter/material.dart';

class ChangeBoiler with ChangeNotifier {
  ChangeBoiler() {
    _example = 0;
  }

  int _example;
  int get example => _example;
  void setExample(int example) {
    _example = example;
    notifyListeners();
  }
}
