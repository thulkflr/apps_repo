import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_flutter/Styles/colors.dart';

ThemeData lightTheme = ThemeData(

  textTheme: TextTheme(bodyText1: TextStyle(
    fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black
  )),
    primarySwatch: Colors.blueGrey,
    appBarTheme:   AppBarTheme(iconTheme:IconThemeData( color:Colors.black),
      titleSpacing: 20,
      color: Colors.white,
      titleTextStyle: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark, statusBarColor: Colors.black12),
    ),
    scaffoldBackgroundColor: Colors.white,
    bottomNavigationBarTheme:   BottomNavigationBarThemeData(
        unselectedItemColor: Colors.black,
        elevation: 20.0,
        selectedItemColor: defaultColor.shade800,
        backgroundColor: Colors.white10,
        type: BottomNavigationBarType.fixed),
    fontFamily: 'Jannah',
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: Colors.blueGrey));
ThemeData darkTheme = ThemeData.dark();
