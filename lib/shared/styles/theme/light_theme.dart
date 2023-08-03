import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: 'ChivoMono',
  primarySwatch: defaultColor,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 20,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    titleSpacing: 20,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white,
    ),
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: 28,
    ),
  ),
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      fontFamily: 'ChivoMono',
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      height: 1.3,
    ),
    titleMedium: TextStyle(
      fontFamily: 'ChivoMono',
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.3,
    ),
  ),
);
