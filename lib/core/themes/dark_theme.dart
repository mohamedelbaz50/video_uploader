import 'package:flutter/material.dart';
import 'package:video_uploader/core/themes/colors.dart';

ThemeData darkTheme = ThemeData(
    drawerTheme: DrawerThemeData(
      backgroundColor: MyColors.darkBackGround,
    ),
    scaffoldBackgroundColor: MyColors.darkBackGround,
    focusColor: Colors.white,
    textTheme: const TextTheme(
        titleSmall: TextStyle(fontSize: 18, color: Colors.black),
        bodySmall: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(
            color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
    fontFamily: "Amiri",
    appBarTheme: AppBarTheme(
        titleTextStyle: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        elevation: 0,
        backgroundColor: MyColors.darkBackGround,
        iconTheme: const IconThemeData(color: Colors.white)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: MyColors.lightPurple,
        unselectedItemColor: Colors.white,
        backgroundColor: MyColors.darkBackGround));
