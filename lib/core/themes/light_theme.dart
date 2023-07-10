import 'package:flutter/material.dart';
import 'package:video_uploader/core/themes/colors.dart';

ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    focusColor: Colors.black,
    drawerTheme: const DrawerThemeData(
      backgroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
        titleSmall: TextStyle(fontSize: 18, color: Colors.black),
        bodySmall: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(
            color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(
            color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold)),
    fontFamily: "Amiri",
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: MyColors.lightPurple,
        unselectedItemColor: Colors.grey[400]));
