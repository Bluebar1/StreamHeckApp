import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

/*
Created NB 5/2020

Server Provider used to run paste commands

needs further info.....


*/

class ServerProvider with ChangeNotifier {
  String _host = '192.168.1.100';
  String path = 'file.txt';

  String _str = 'none';
  String get str => _str;

  Map jsonData = {
    'name': 'Nick MEMEME',
    'job': 'reluctant hero',
    'BFF': 'Chewbacca',
    'ship': 'Millennium Falcon',
    'weakness': 'smuggling debts'
  };

  ServerProvider() {
    setUp();
  }

  Future setUp() async {
    try {
      final request = await HttpClient().post(_host, 4049, path)
        ..headers.contentType = ContentType.json
        ..write(jsonEncode(jsonData));
      final response = await request.close();
      await utf8.decoder.bind(response).forEach((res) => setString(res));
    } catch (err) {
      print('setup error called:::: $err');
    }
  }

  Future runBoilerPlate() async {
    try {
      final request = await HttpClient().post(_host, 4049, 'paste')
        ..headers.contentType = ContentType.json
        ..write(jsonEncode(jsonData));
      final response = await request.close();
      await utf8.decoder.bind(response).forEach((res) {
        boilerPlateStatus(res);
      });
    } catch (err) {
      print('BoilerPlate Error Code::: $err');
    }
  }

  void boilerPlateStatus(String res) async {
    print('BOILER PLATE STATUS FUNCTION CALLED : $str');
  }

  void setString(String res) {
    _str = res;
    notifyListeners();
  }
}
