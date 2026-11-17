import 'package:flutter/material.dart';
import 'package:flutter_proyecto_reservar_espacios/ui/acceso/ui/registro_screen.dart';
import 'package:flutter_proyecto_reservar_espacios/ui/espacios/ui/espacios_screen.dart';
import 'package:flutter_proyecto_reservar_espacios/utils/anadir_placeholder.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              AnadirPlaceholder(altura: 150, anchura: 300),

              const SizedBox(height: 32),

              Center(
                //Establece un limite de tamaño que puede usar todo lo que esta dentro de aqui sin esto con solo center todo ocuparia toda la pantalla
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 350),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch, // Para que los botones ocupen el ancho de los campos
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Correo electrónico',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),

                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Contraseña',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(height: 24),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (context) => const EspaciosScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Entrar',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Text("¿No tienes cuenta?"),
                            TextButton(
                              // style: TextButton.styleFrom(
                              //   backgroundColor: Colors.white,
                              // ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (context) => RegistroScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Registrate ->',
                                // style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
