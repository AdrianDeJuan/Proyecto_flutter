import 'package:flutter/material.dart';
import 'package:flutter_proyecto_reservar_espacios/ui/acceso/ui/login_screen.dart';

void main() {
  runApp(const ReservaApp());
}

class ReservaApp extends StatelessWidget {
  const ReservaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //const?
      debugShowCheckedModeBanner: false,
      title: 'Reserva de espacios',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2563EB)),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2563EB),
          foregroundColor: Colors.white,
        ),
      ),
      home: LoginScreen(),
    );
  }
}
