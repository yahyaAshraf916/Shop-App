import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
  textTheme: const TextTheme(
      bodyText1: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black)),
  primarySwatch: defaultcolor,
  appBarTheme: const AppBarTheme(
      titleSpacing: 20,
      iconTheme: IconThemeData(color: Colors.black),
      color: Colors.white,
      elevation: 0,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      )),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultcolor,
    unselectedItemColor: Colors.grey,
    elevation: 20,
  ),
);
