import 'package:flutter/material.dart';

class AppTheme {
    //definimos el primary color
    static const Color primary = Colors.indigoAccent;

    static final ThemeData lightTheme = ThemeData.light().copyWith(
        
        //Color Primario
        primaryColor:primary,
        
        //AppBar theme
        appBarTheme: const AppBarTheme(
          color:primary,
          elevation: 0
        )
    );
}