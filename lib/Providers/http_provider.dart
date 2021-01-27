import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:streamheck/models/available_macro_model.dart';
import 'dart:convert' as convert;
import 'package:streamheck/models/macro.dart';

/*
Created NB 5/2020

HttpProvider connects to the HttpServer and recieves JSON
data to display in the grid view of the current tab selected

When a new tab is selected, a new http get request is sent 
for the new tabs data. This JSON data is converted to a List
of Macro objects
*/

class HttpProvider with ChangeNotifier {
  HttpProvider(String file, String type) {
    _macroList = null;
    _availMacroList = null;
    print('HTTP PROVIDER CONSTRUCTOR CALLED');
    runHttpReq(file, type);
  }

  List<dynamic> _macroList;
  List<dynamic> get macroList => _macroList;
  setMacroList(List<dynamic> macros) {
    _macroList = macros;
    notifyListeners();
  }

  List<dynamic> _availMacroList;
  List<dynamic> get availMacroList => _availMacroList;
  setAvailMacroList(List<dynamic> availMacroList) {
    print('SET AVAIL CALLED');
    _availMacroList = availMacroList;
    notifyListeners();
  }

  runHttpReq(String file, String type) async {
    print("http provider runhttp req, file: " + file + 'type: ' + type);
    _macroList = null;
    _availMacroList = null;
    // Map<String, String> requestHeaders = {'getType': '$type'};
    // String url = Uri.encodeFull('http://192.168.1.100:4044/' + file);

    switch (type) {
      case 'pages':
        getPage(file, type);
        break;
      case 'availMacros':
        getAvailMacros(file, type);
        break;
      default:
        print('ERROR : Default http req called ');
    }
  }

  void getPage(String file, String type) async {
    Map<String, String> requestHeaders = {'getType': '$type'};
    String url = Uri.encodeFull('http://192.168.1.100:4044/' + file);
    try {
      var response = await http.get(url, headers: requestHeaders);
      var json = convert.jsonDecode(response.body);
      // print('JSON runtimetype:: '+json[0]);
      if (json is List) {
        print("JSON IS LIST");
        var jsonResults = json as List;
        
        setMacroList(jsonResults.map((e) => Macro.fromJson(e)).toList());
      } else {
        print('json is NOT LIST');
        var jsonResults = json as List;
        
        setMacroList(jsonResults.map((e) => Macro.fromJson(e)).toList());
      }

      
    } catch (err) {
      print('RUN HTTP REQ ERROR : $err');
      //setMacroList(Macro.emptyList());
    }
  }

  void getAvailMacros(String file, String type) async {
    Map<String, String> requestHeaders = {'getType': '$type'};
    String url = Uri.encodeFull('http://192.168.1.100:4044/' + file);
    try {
      var response = await http.get(url, headers: requestHeaders);
      var json = convert.jsonDecode(response.body);
      var jsonResults = json as List;
      setAvailMacroList(
          jsonResults.map((e) => AvailableMacro.fromJson(e)).toList());
    } catch (err) {
      print('RUN HTTP REQ 2ERROR : $err');
    }
  }
}
//   if (type == 'pages') {
//     try {
//       var response = await http.get(url, headers: requestHeaders);
//       var json = convert.jsonDecode(response.body);
//       var jsonResults = json as List;
//       setMacroList(jsonResults.map((e) => Macro.fromJson(e)).toList());
//     } catch (err) {
//       print('RUN HTTP REQ ERROR : $err');
//     }
//   } else if (type == 'availMacros') {
//     try {
//       var response = await http.get(url, headers: requestHeaders);
//       var json = convert.jsonDecode(response.body);
//       var jsonResults = json as List;
//       setAvailMacroList(
//           jsonResults.map((e) => AvailableMacro.fromJson(e)).toList());
//     } catch (err) {
//       print('RUN HTTP REQ ERROR : $err');
//     }
//   }
// }
