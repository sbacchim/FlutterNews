import 'package:flutter/material.dart';

final appTheme = ThemeData(
    appBarTheme: AppBarTheme(color: Colors.white),
    fontFamily: 'Roboto',
    brightness: Brightness.light);

final searchTheme = ThemeData(
  primaryColor: Colors.white,
  textTheme: TextTheme(
    headline6: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 14,
    ),
  ),
);
