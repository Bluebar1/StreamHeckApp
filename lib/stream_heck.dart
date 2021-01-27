import 'package:flutter/material.dart';
import 'package:streamheck/Screens/contacts.dart';
import 'package:streamheck/Screens/home.dart';
import 'package:streamheck/style.dart';

class StreamHeck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            textTheme: TextTheme(
                bodyText1: ModuleTextStyle, bodyText2: StatusTextStyle),
            sliderTheme: SliderThemeData(trackHeight: 40)),
        home: ContactsScreen());
  }
}
