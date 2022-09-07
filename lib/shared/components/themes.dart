import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors_style.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  backgroundColor: const Color.fromRGBO(243, 242, 243, 1),
  cardColor: const Color.fromRGBO(255, 254, 254, 1),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50), borderSide: BorderSide.none),
    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
    filled: true,
    fillColor: Color.fromRGBO(243, 242, 243, 1),
    floatingLabelStyle: TextStyle(color: defaultColor,height: 0.0),
    focusColor: defaultColor,
    prefixIconColor: defaultColor,
    suffixIconColor: defaultColor,
    floatingLabelAlignment: FloatingLabelAlignment.start,
  ),
  textTheme: const TextTheme(
    headline6: TextStyle(color: Colors.black),
    headline3: TextStyle(color: Colors.black),
    headline4: TextStyle(color: Colors.black),
  ),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
    elevation: 0.0,
    color: Colors.white,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white,
    ),
    titleTextStyle:  TextStyle(
      //fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      fontFamily: 'SeaSandSun',
      color: Colors.black,
      fontSize: 70,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: const Color.fromRGBO(1, 0, 1, 1),
  backgroundColor: const Color.fromRGBO(243, 242, 243, 1),
  cardColor: const Color.fromRGBO(25, 25, 25, 1),

  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50), borderSide: BorderSide.none),
    contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
    filled: true,
    fillColor: const Color.fromRGBO(243, 242, 243, 1),
    floatingLabelStyle: const TextStyle(color: defaultColor,height: 0,fontWeight: FontWeight.bold,fontSize: 20,),
    focusColor: defaultColor,
    prefixIconColor: defaultColor,
    suffixIconColor: defaultColor,
    floatingLabelAlignment: FloatingLabelAlignment.start,
  ),
  textTheme: const TextTheme(
    headline6: TextStyle(color: Colors.white),
    headline3: TextStyle(color: Colors.white),
    headline4: TextStyle(color: Colors.white),
    caption: TextStyle(color: Colors.grey),
  ),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    elevation: 0.0,
    color: Color.fromRGBO(1, 0, 1, 1),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Color.fromRGBO(1, 0, 1, 1),
    ),
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      fontFamily: 'SeaSandSun',
      color: Colors.white,
      fontSize: 70,
    ),
  ),
);
