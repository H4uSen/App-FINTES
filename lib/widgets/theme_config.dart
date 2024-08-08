import 'package:flutter/material.dart';

class CustomColors {
  static const Color white = Color.fromRGBO(253, 255, 226, 1);
  static const Color black = Color.fromRGBO(26, 33, 48, 1);
  static const Color lightBlue = Color.fromRGBO(131, 180, 255, 1);
  static const Color darkBlue = Color.fromRGBO(90, 114, 160, 1);
  static const Color green = Color.fromARGB(255, 64, 172, 68);
  static const Color red =  Color.fromARGB(255, 189, 64, 55);
}



ThemeData customThemeData = ThemeData(
        fontFamily:'Roboto',
        primaryColor: CustomColors.lightBlue,
        scaffoldBackgroundColor: CustomColors.white,
        buttonTheme: const ButtonThemeData(
          buttonColor: CustomColors.darkBlue,
          textTheme: ButtonTextTheme.primary,
        ),
        appBarTheme:const AppBarTheme(
          backgroundColor: CustomColors.lightBlue,
          titleTextStyle: TextStyle(color: CustomColors.black, fontSize: 30, fontFamily: 'Roboto', wordSpacing: 2),
        ),
        textTheme: const TextTheme(
          
          titleSmall: TextStyle(color: CustomColors.black, fontSize: 20, wordSpacing: 2, overflow: TextOverflow.ellipsis),
          bodySmall: TextStyle(color: CustomColors.black, fontSize: 15, wordSpacing: 2, overflow: TextOverflow.ellipsis),
          headlineSmall: TextStyle(color: CustomColors.black, fontSize: 25, wordSpacing: 2, overflow: TextOverflow.ellipsis),

          titleMedium: TextStyle(color: CustomColors.black, fontSize: 30, wordSpacing: 2, overflow: TextOverflow.ellipsis),
          bodyMedium: TextStyle(color: CustomColors.black, fontSize: 20, wordSpacing: 2, overflow: TextOverflow.ellipsis),
          headlineMedium: TextStyle(color: CustomColors.black, fontSize: 35, wordSpacing: 2, overflow: TextOverflow.ellipsis),
          labelMedium: TextStyle(color: CustomColors.black, fontSize: 20, wordSpacing: 2, overflow: TextOverflow.ellipsis),

          titleLarge: TextStyle(color: CustomColors.black, fontSize: 40, wordSpacing: 2, overflow: TextOverflow.ellipsis),
          bodyLarge: TextStyle(color: CustomColors.black, fontSize: 25, wordSpacing: 2, overflow: TextOverflow.ellipsis),
          headlineLarge: TextStyle(color: CustomColors.black, fontSize: 45, wordSpacing: 2, overflow: TextOverflow.ellipsis),
          labelLarge: TextStyle(color: CustomColors.black, fontSize: 25, wordSpacing: 2, overflow: TextOverflow.ellipsis),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: CustomColors.darkBlue,
          foregroundColor: CustomColors.white,
        ),

        
      );