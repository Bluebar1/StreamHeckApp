import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' show utf8;
import 'dart:convert';
import 'package:http/http.dart' as http;

class MacroPagesProvider with ChangeNotifier {
  var uri = Uri.parse('http://192.168.1.100:4044');

  TextEditingController _newPageController;
  TextEditingController get newPageController => _newPageController;

  String _newFileName;
  String get newFileName => _newFileName;
  setNewFileName(String newFileName) {
    _newFileName = newFileName;
    //notifyListeners();
  }

  List<String> _macroPageList = ['Macros', 'Windows Keys', 'Flutter Paste'];
  List<String> get macroPageList => _macroPageList;
  setMacroPageList(List<String> macroPageList) {
    _macroPageList = macroPageList;
    notifyListeners();
  }

  MacroPagesProvider() {
    print('macro provider called');
    setMacroPageList([]);
    loadPreferences();
    startTextController();
  }

  startTextController() {
    print('start new text controller called');
    _newPageController = TextEditingController();
  }

  addMacroPage(String name) {
    _macroPageList.add(name);
    notifyListeners();
    savePreferences();
  }

  addNewPageToServer(String page) async {
    print('add new page to server called');
    //Map<String, String> requestHeaders = {'postType': 'addPage'};
    try {
      final request = await HttpClient()
          .post('192.168.1.100', 4044, convertToFileFormat(page))
        //..headers.contentType = ContentType.json
        ..headers.add('postType', 'addPage');
      //..write(convert.jsonEncode(makeMacro()));
      final response = await request.close();
      await utf8.decoder.bind(response).forEach((res) => print(res));
    } catch (err) {
      print('ADD NEW PAGE TO SERVER ERROR : $err');
    }
  }

  reorderPages(int oldIndex, int newIndex) {
    //var _tempList = <String>[];
    if (newIndex > _macroPageList.length || oldIndex < newIndex) newIndex--;
    print('reorder pages called $oldIndex : $newIndex');
    print('starting state macrolist: $_macroPageList');
    var _tempList = <String>[]; //_macroPageList;
    _tempList.addAll(_macroPageList);
    print('starting state templist: $_tempList');
    //_tempList.add('');
    _tempList.removeAt(oldIndex);
    print('after remove at: $_tempList');
    _tempList.insert(newIndex, '${_macroPageList[oldIndex]}');
    print('after insert: $_tempList');
    setMacroPageList(_tempList);
  }

  String convertToFileFormat(String page) {
    // String _tempString = page;
    // _tempString
    return page.replaceAll(' ', '_').toLowerCase() + '.json';
  }

  void savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('macroPageList', _macroPageList);
  }

  void loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setStringList(
         'macroPageList', ['Macros', 'Windows Keys', 'Flutter Paste', 'Testing']);
    List<String> macroPageList = prefs.getStringList('macroPageList');

    if (macroPageList != null) setMacroPageList(macroPageList);
  }
}
