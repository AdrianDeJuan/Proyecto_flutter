import 'package:flutter/material.dart';

import 'app_dependencies.dart';
import 'app_theme.dart';
import 'ui/acceso/ui/login_screen.dart';

void main() {
  // Creamos una única instancia con los servicios, repositorios y ViewModels.
  // Las pantallas recibirán estas dependencias cuando las necesiten.
  final dependencias = AppDependencies();

  // Arrancamos Flutter mostrando la pantalla de inicio de sesión.
  runApp(ReservaEspaciosApp(dependencias: dependencias));
}

/// Widget raíz de la aplicación.
class ReservaEspaciosApp extends StatelessWidget {
  const ReservaEspaciosApp({
    super.key,
    required this.dependencias,
  });

  // Conservamos las dependencias para compartir los mismos datos
  // y repositorios durante toda la ejecución de la aplicación.
  final AppDependencies dependencias;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reserva de espacios',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.tema,

      // Navigator empieza mostrando LoginScreen.
      // Las siguientes pantallas se abrirán con Navigator.push.
      home: LoginScreen(dependencias: dependencias),
    );
  }
}
