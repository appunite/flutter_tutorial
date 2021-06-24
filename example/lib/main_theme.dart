import 'package:flutter/material.dart';

ThemeData get mainTheme => ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
      ),
      accentColor: const Color(0xFF35b9aa),
      scaffoldBackgroundColor: Colors.white,
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const Color(0xFF35b9aa)),
          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
        ),
      ),
    );
