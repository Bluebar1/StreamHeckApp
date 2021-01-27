import 'package:flutter/material.dart';

const LargeTextSize = 26.0;
const MediumTextSize = 20.0;
const BodyTextSize = 16.5;
const StatusTextSize = 12.3;

const String FontDefaultName = 'Montserrat';

const ModuleTextStyle = TextStyle(
    fontFamily: FontDefaultName,
    fontWeight: FontWeight.w600,
    fontSize: MediumTextSize,
    color: Color.fromRGBO(230, 230, 230, 1.0));

const StatusTextStyle = TextStyle(
    fontFamily: FontDefaultName,
    fontWeight: FontWeight.w600,
    fontSize: LargeTextSize,
    color: Color.fromRGBO(10, 10, 10, 1.0));

const UnimportantTextStyle = TextStyle(
    fontFamily: FontDefaultName,
    fontWeight: FontWeight.w600,
    fontSize: 12,
    color: Color.fromRGBO(120, 120, 120, 1));

final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  accentColor: Colors.white,
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black12,
);

final lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.white,
  brightness: Brightness.light,
  backgroundColor: const Color(0xFFE5E5E5),
  accentColor: Colors.black,
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.white54,
);
