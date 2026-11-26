import 'package:flutter/material.dart';

/// Define los estilos comunes para que las pantallas mantengan una apariencia uniforme.
class AppTheme {
  static const Color colorMarca = Color(0xFF245B73);
  static const Color colorFondo = Color(0xFFF4F7F9);
  static const Color colorTexto = Color(0xFF18323D);

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
        backgroundColor: colorMarca,
        foregroundColor: Colors.white,
        centerTitle: false,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
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
        titleLarge: TextStyle(
          color: colorTexto,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
