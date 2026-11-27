import 'package:flutter/material.dart';

/// Define los estilos comunes para que las pantallas mantengan una apariencia uniforme.
class AppTheme {
  static const Color colorMarca = Color(0xFF245B73);
  static const Color colorFondo = Color(0xFFF1E8D4);
  static const Color colorTexto = Color(0xFF18323D);
  static const Color colorAppBar = Color(0xFF263B70);
  static const Color colorFormulario = Color(0xFFFFF9EC);
  static const Color colorBordeFormulario = Color(0xFFD9B65D);
  static const Color colorBotonPrincipal = Color(0xFFF4B832);
  static const Color colorBotonSecundario = Color.fromARGB(255, 73, 129, 212);
  static const Color colorTextoBoton = Color(0xFF172033);
  static const Color colorFondoTextButton = Color(0xFFE3EAF2);

  static ThemeData get tema {
    final esquema = ColorScheme.fromSeed(
      seedColor: colorMarca,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: esquema,
      scaffoldBackgroundColor: colorFondo,
      appBarTheme: const AppBarTheme(
        backgroundColor: colorAppBar,
        foregroundColor: Colors.white,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blueGrey.shade100),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(0, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          color: colorTexto,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(color: colorTexto, fontWeight: FontWeight.bold),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colorBotonPrincipal,
          foregroundColor: colorTextoBoton,
          minimumSize: const Size(0, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: colorBotonSecundario,
          foregroundColor: Colors.white,
          side: const BorderSide(color: colorBotonSecundario),
          minimumSize: const Size(0, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorAppBar,
          backgroundColor: colorFondoTextButton,
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
