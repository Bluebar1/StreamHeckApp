import 'package:flutter/material.dart';
import 'package:streamheck/models/available_macro_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AvailMacroService with ChangeNotifier {
  //with ChangeNotifier {

  // List<dynamic> _availMacros;
  // List<dynamic> get availMacros => _availMacros;
  // setAvailMacros(List<dynamic> availMacros) {
  //   _availMacros = availMacros;
  //   notifyListeners();
  // }
  List<dynamic> availMacros = [];
  bool isDoneLoading;

  void startTimer() async {
    await Future.delayed(Duration(seconds: 2));
    isDoneLoading = true;
    notifyListeners();
  }

  setAvailMacros(List<dynamic> am) {
    print('SET CALLED');
    availMacros = am;
    notifyListeners();
  }

  void getAvailMacros() async {
    print('get avail macros called');
    await Future.delayed(Duration(seconds: 2));
    print('delay done');
    Map<String, String> requestHeaders = {'getType': 'availMacros'};
    String url =
        Uri.encodeFull('http://192.168.1.100:4044/' + 'doesthismatter.text');

    try {
      var response = await http.get(url, headers: requestHeaders);
      var json = convert.jsonDecode(response.body);
      //print('try print');
      //print(json.toString());
      var jsonResults = json as List;
      print('as list : $jsonResults');
      setAvailMacros(availMacros =
          jsonResults.map((e) => AvailableMacro.fromJson(e)).toList());
      // print('ABOUT TO NOTIFY');
      // notifyListeners();
    } catch (err) {
      print('RUN HTTP REQ ERROR : $err');
    }
  }
}
