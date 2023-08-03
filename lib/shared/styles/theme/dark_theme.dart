import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app1/constants.dart';

ThemeData darkTheme = ThemeData(
  fontFamily: 'ChivoMono',
  primarySwatch: defaultColor,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: HexColor('333739'),
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
  ),
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
    backgroundColor: HexColor('333739'),
    elevation: 0,
    titleSpacing: 20,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: const TextStyle(
      fontFamily: 'ChivoMono',
      fontSize: 25,
      color: Colors.white,
      fontWeight: FontWeight.w400,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarBrightness: Brightness.light,
    ),
  ),
  textTheme: const TextTheme(
    bodySmall: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.3),
    titleMedium: TextStyle(
      fontFamily: 'ChivoMono',
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.3,
    ),
  ),
);
