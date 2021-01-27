import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:streamheck/models/available_macro_model.dart';

class AvailProvider with ChangeNotifier {
  List<String> _menuList;
  List<String> get menuList => _menuList;
  setMenuList(List<String> menuList) {
    _menuList = menuList;
    notifyListeners();
  }

  List<dynamic> _availList;
  List<dynamic> get availList => _availList;
  setAvailList(List<dynamic> availList) {
    //make string list for menu viewing
    List<String> _temp = [];
    availList.forEach((element) {
      _temp.add(element.combo);
    });
    setMenuList(_temp);

    _availList = availList;
    notifyListeners();
  }

  AvailProvider() {
    _availList = null;
    _menuList = [];
    runAvail();
  }

  void runAvail() async {
    print("avail provider runavail called");
    Map<String, String> requestHeaders = {'getType': 'availMacros'};
    String url = Uri.encodeFull('http://192.168.1.100:4044/' + 'nothing.txt');
    try {
      var response = await http.get(url, headers: requestHeaders);
      var json = convert.jsonDecode(response.body);
      var jsonResults = json as List;

      setAvailList(jsonResults.map((e) => AvailableMacro.fromJson(e)).toList());
    } catch (err) {
      print('RUN HTTP REQ ERROR : $err');
    }
  }
}
