import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

ThemeData darkTheme(BuildContext context) => ThemeData(
      fontFamily: 'Jannah',
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('333739'),
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: HexColor('333739'),
        elevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: 'Jannah',
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: const OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      hintColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.white),
      scaffoldBackgroundColor: HexColor('333739'),
      primarySwatch: defaultColor,
      // primaryColor: Colors.white,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: defaultColor,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: HexColor('333739'),
        selectedItemColor: defaultColor,
        unselectedItemColor: Colors.grey,
        elevation: 20,
        type: BottomNavigationBarType.fixed,
      ),
      textTheme: TextTheme(
        subtitle1: Theme.of(context).textTheme.subtitle1.copyWith(
              fontFamily: 'Jannah',
              color: Colors.white,
            ),
        bodyText2: Theme.of(context).textTheme.bodyText2.copyWith(
              fontFamily: 'Jannah',
              color: Colors.white,
            ),
        bodyText1: TextStyle(
          fontFamily: 'Jannah',
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

ThemeData lightTheme(BuildContext context) => ThemeData(
      brightness: Brightness.light,
      fontFamily: 'Jannah',
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontFamily: 'Jannah',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
      primarySwatch: defaultColor,
      textTheme: TextTheme(
        subtitle1: Theme.of(context).textTheme.subtitle1.copyWith(
              color: Colors.black,
              fontFamily: 'Jannah',
            ),
        bodyText2: Theme.of(context).textTheme.bodyText2.copyWith(
              fontFamily: 'Jannah',
              color: Colors.black,
            ),
        bodyText1: TextStyle(
          fontFamily: 'Jannah',
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: defaultColor,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: defaultColor,
        elevation: 20,
        type: BottomNavigationBarType.fixed,
      ),
    );
