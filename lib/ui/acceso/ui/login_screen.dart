import 'package:flutter/material.dart';
import '../../../app_dependencies.dart';
import '../../espacios/ui/espacios_screen.dart';
import 'registro_screen.dart';

/// Pantalla de acceso de demostración.
/// No autentica contra un servidor: permite entrar al catálogo.
class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
    required this.dependencias,
  });

  // Recibimos las dependencias creadas al iniciar la aplicación.
  final AppDependencies dependencias;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(Icons.meeting_room_outlined, size: 58),
                      const SizedBox(height: 16),
                      Text(
                        'Reserva de espacios',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Encuentra el espacio adecuado para tu actividad.',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 28),
                      const TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Correo electrónico',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                      ),
                      const SizedBox(height: 14),
                      const TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          prefixIcon: Icon(Icons.lock_outline),
                        ),
                      ),
                      const SizedBox(height: 22),
                      FilledButton(
                        // El acceso es simulado y lleva directamente al catálogo.
                        onPressed: () {
                          // Abrimos el catálogo y eliminamos el Login del historial.
                          // Así, al pulsar atrás desde el catálogo, no volvemos al acceso.
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EspaciosScreen(
                                viewModel: dependencias.espaciosViewModel,
                                dependencias: dependencias,
                              ),
                            ),
                            (route) => false,
                          );
                        },
                        child: const Text('Entrar'),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () {
                          // Abrimos el formulario de registro encima del Login.
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegistroScreen(),
                            ),
                          );
                        },
                        child: const Text('¿No tienes cuenta? Regístrate'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
