import 'package:flutter/material.dart';

ThemeData get textEditTheme => ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
      ),
      colorScheme: const ColorScheme.light(
        secondary: Color(0xFF35b9aa),
      ),
      primaryColor: const Color(0xFF166259),
      scaffoldBackgroundColor: Colors.white,
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const Color(0xFF35b9aa)),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
          side: MaterialStateProperty.all(
              const BorderSide(color: Colors.white, width: 2)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
        ),
      ),
    );
