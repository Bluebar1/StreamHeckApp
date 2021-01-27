import 'dart:convert' show utf8;
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:streamheck/Screens/contacts.dart';
import 'package:streamheck/models/macro.dart';
import 'package:path/path.dart';

/*
Created NB 5/2020

This class stores all the active data for creating a 
new action tile.

This is a main concern for performance because it has so
many listeners.

There is currently a wipe() function to reset all of the data 
but this should not be necessary because the provider should be 
disposed when it is not in use, and reset upon reignition.

When the user clicks the add macro button, the makeMacro() function is called
to create a macro and send it to the http server to store it in a JSON file

If the user selected an Image as the background, that image is uploaded 
to the Http File server to be accessed later in a GET call
*/

class BoxCreateProvider with ChangeNotifier {
  String _host = '192.168.1.100';
  var uri = Uri.parse('http://192.168.1.100:4044'); //4046/');
  String _text;
  String get text => _text;
  HttpRequest hrequest;

  BoxCreateProvider() {
    print('box create provider called');
    _singleColor = Colors.white;
    _firstGradientColor = Colors.white;
    _secondGradientColor = Colors.white;
    _fontColor = Colors.black;
    _title = 'change me';
    _text = 'true dat';
    _fontSize = 30.0;
    _topPosition = 0.0;
    _leftPosition = 0.0;
    _fontSelection = 'None';
    _actionSelection = 'Macro';
    _leftSelection = 0;
    _bgList = ['Color', 'Gradient', 'Library'];
    _addressController = TextEditingController();
    _actionInputController = TextEditingController();
    _pasteInputController = TextEditingController();
    _pickedImage = null;
    _actionType = '';
    _action = '';
  }

  Macro makeMacro() {
    return Macro(
        _title,
        _text,
        _singleColor.value,
        _firstGradientColor.value,
        _secondGradientColor.value,
        _fontColor.value,
        _fontSize,
        _topPosition,
        _leftPosition,
        _fontSelection,
        _leftSelection,
        (pickedImage != null) ? '${basename(pickedImage.path)}' : 'no pic',
        _actionSelection,
        _actionInputController.value.text);
  }

  addNewMacroBox(String customTab) async {
    print('add new macro box called');
    print(_actionSelection);
    try {
      final request = await HttpClient().post(_host, 4044, customTab)
        ..headers.contentType = ContentType.json
        ..headers.add('postType', 'addMacro')
        ..write(jsonEncode(makeMacro()));
      final response = await request.close();
      await utf8.decoder
          .bind(response)
          .forEach((res) => print(res)); //setString(res));
      if (_leftSelection == 2 && _pickedImage != null) {
        print('UPLOAD IMAGE ABOUT TO BE CALLED');
        uploadImage(customTab);
      }
    } catch (err) {
      print('setup error called:::: $err');
    }

    if (_actionSelection == 'HotKey') {
      appendHotKeyToScript();
    }
  }

  String scriptBuilder() {
    return '';
  }

  void appendHotKeyToScript() async {
    String _hotKey = _action;

    Map script = {
      'script': '\n\n>^>!>+' + '$_hotKey' + '::\n Send, $_paste \n return \n'
    };
    //String tt = 'testing new file make with string';
    print('append hot key to script called');
    try {
      final request = await HttpClient().post(_host, 4044, '')
        ..headers.contentType = ContentType.json
        ..headers.add('postType', 'addHotKey')
        ..write(jsonEncode(script));
      final response = await request.close();
      await utf8.decoder.bind(response).forEach((res) => print(res));
    } catch (err) {
      print(err);
    }
  }

  void uploadImage(String customTab) async {
    print('marker 1');
    Map<String, String> requestHeaders = {'postType': 'addImage'};
    var request = http.MultipartRequest("POST", uri)
      ..headers.addAll(requestHeaders);
    //..fields['postType'] = 'addImage';
    print('marker 2');
    var multipartFile = await http.MultipartFile.fromPath(
        "package", _pickedImage.path,
        contentType: MediaType('image', 'png'));
    request.files.add(multipartFile);
    print('marker 3');
    http.StreamedResponse response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  //
  Color _singleColor;
  Color get color => _singleColor;
  setColor(Color color) {
    _singleColor = color;
    notifyListeners();
  }
  //

  Color _firstGradientColor;
  Color get firstGradientColor => _firstGradientColor;
  setFirstGradientColor(Color firstGradientColor) {
    _firstGradientColor = firstGradientColor;
    notifyListeners();
  }

  //

  Color _secondGradientColor;
  Color get secondGradientColor => _secondGradientColor;
  setSecondGradientColor(Color secondGradientColor) {
    _secondGradientColor = secondGradientColor;
    notifyListeners();
  }
  //

  Color _fontColor;
  Color get fontColor => _fontColor;
  setFontColor(Color fontColor) {
    _fontColor = fontColor;
    notifyListeners();
  }

  //
  String _title;
  String get title => _title;
  setTitle(String title) {
    _title = title;
    notifyListeners();
  }

  //
  double _fontSize;
  double get fontSize => _fontSize;
  setFontSize(double fontSize) {
    _fontSize = fontSize;
    notifyListeners();
  }

  //
  double _topPosition;
  double get topPosition => _topPosition;
  setTopPosition(double topPosition) {
    _topPosition = topPosition;
    notifyListeners();
  }

  //
  double _leftPosition;
  double get leftPosition => _leftPosition;
  setLeftPosition(double leftPosition) {
    _leftPosition = leftPosition;
    notifyListeners();
  }

  //

  String _fontSelection;
  String get fontSelection => _fontSelection;
  setFontSelection(String fontSelection) {
    _fontSelection = fontSelection;
    notifyListeners();
  }
  //

  String _actionSelection;
  String get actionSelection => _actionSelection;
  setActionSelection(String actionSelection) {
    print('action selection changed to : $actionSelection');
    _actionSelection = actionSelection;
    notifyListeners();
  }

  int _leftSelection;
  int get leftSelection => _leftSelection;
  setLeftSelection(int leftSelection) {
    _leftSelection = leftSelection;
    notifyListeners();
  }
  //

  File _pickedImage;
  File get pickedImage => _pickedImage;
  setPickedImage(File pickedImage) async {
    _pickedImage = pickedImage;
    notifyListeners();
  }

  String _actionType;
  String get actionType => _actionType;
  setActionType(String actionType) {
    print('set action type called');

    _actionType = actionType;
    print(_actionType);
  }

  String _action;
  String get action => _action;
  setAction(String action) {
    _action = action;
    notifyListeners();
  }

  String _paste;
  String get paste => _paste;
  setPaste(String paste) {
    _paste = paste;
    notifyListeners();
  }

  //
  TextEditingController _addressController;
  TextEditingController get addressController => _addressController;
  //
  TextEditingController _actionInputController;
  TextEditingController get actionInputController => _actionInputController;
  //

  TextEditingController _pasteInputController;
  TextEditingController get pasteInputController => _pasteInputController;

  List<String> _bgList;
  List<String> get bgList => _bgList;

  //

  void wipe() {
    _singleColor = Colors.white;
    _firstGradientColor = Colors.white;
    _secondGradientColor = Colors.white;
    _fontColor = Colors.black;
    _title = 'change me';
    _fontSize = 30.0;
    _topPosition = 0;
    _leftPosition = 0;
    _fontSelection = 'None';
    _actionSelection = 'Macro';
    _leftSelection = 0;
    _pickedImage = null;
    _actionType = '';
    _action = '';
    _addressController.clear();
    _actionInputController.clear();
    _pasteInputController.clear();
  }
}
