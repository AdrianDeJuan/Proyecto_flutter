import 'package:flutter/material.dart';

/// Formulario visual de registro.
/// La entrega utiliza datos simulados, por lo que no crea usuarios persistentes.
class RegistroScreen extends StatelessWidget {
  const RegistroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear cuenta')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Regístrate', style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 20),
                    const TextField(
                      decoration: InputDecoration(
                        labelText: 'Nombre completo',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                    ),
                    const SizedBox(height: 14),
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
                    const SizedBox(height: 14),
                    const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Repetir contraseña',
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                    ),
                    const SizedBox(height: 22),
                    FilledButton(
                      // No se guarda una cuenta real en esta entrega.
                      onPressed: () {
                        // Volvemos al Login que quedó debajo del registro.
                        Navigator.pop(context);
                      },
                      child: const Text('Crear cuenta'),
                    ),
                    TextButton(
                      onPressed: () {
                        // El botón de volver también cierra el registro.
                        Navigator.pop(context);
                      },
                      child: const Text('Ya tengo una cuenta'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
