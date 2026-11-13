import 'package:flutter/material.dart';
import 'package:flutter_proyecto_reservar_espacios/ui/acceso/ui/registro_screen.dart';
import 'package:flutter_proyecto_reservar_espacios/ui/espacios/ui/espacios_screen.dart';

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
              Center(
                child: Container(
                  height: 200,
                  width: 1000,
                  //Borde redonde fondo gris
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),

                  //Column para poder poner verticalmente la imagen y texto del placeholder
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, //Esto centra el contenido a la altura del contenedor
                    children: const [
                      Icon(Icons.image_outlined, size: 50, color: Colors.grey),
                      SizedBox(height: 8),
                      Text(
                        'Placeholder de Imagen',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

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
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),

                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Contraseña',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(height: 24),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
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

                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (context) => RegistroScreen(),
                              ),
                            );
                          },
                          child: const Text('¿No tienes cuenta? Registrate'),
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
