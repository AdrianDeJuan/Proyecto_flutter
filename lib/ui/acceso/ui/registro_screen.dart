import 'package:flutter/material.dart';
import 'package:flutter_proyecto_reservar_espacios/ui/acceso/ui/login_screen.dart';
import 'package:flutter_proyecto_reservar_espacios/utils/anadir_placeholder.dart';

class RegistroScreen extends StatelessWidget {
  const RegistroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrarse')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          //Fuerza todos los campos a estirarse, poner center o algo similar para quitar esa obligacion
          child: ListView(
            children: [
              AnadirPlaceholder(altura: 150, anchura: 300),

              const SizedBox(height: 32),

              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 350),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch, // Para que los botones ocupen el ancho de los campos
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Nombre completo',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person),
                          ),
                          keyboardType: TextInputType.name,
                        ),

                        const SizedBox(height: 16),

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
                            border: OutlineInputBorder(), //Define el borde del campo
                            prefixIcon: Icon(Icons.lock),
                          ),
                          obscureText: true, //Oculta caracteres
                        ),
                        const SizedBox(height: 16),

                        TextFormField(
                          //Implementar boton con icono ojo para ver contraseñas cuando pase esto a statefull widget
                          decoration: const InputDecoration(
                            labelText: 'Confirmar contraseña',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                          ),
                          obscureText: true,
                        ),
                        // const SizedBox(height: 16),

                        // TextFormField(
                        //   decoration: const InputDecoration(
                        //     //Implementar para cambiar el numero de nacionalidad del telefono
                        //     labelText: 'Telefono +34',
                        //     border: OutlineInputBorder(),
                        //     prefixIcon: Icon(Icons.phone),
                        //   ),
                        //   keyboardType: TextInputType.number,
                        //   inputFormatters: [
                        //     FilteringTextInputFormatter.digitsOnly,
                        //   ],
                        // ),
                        const SizedBox(height: 24),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () {
                            //Añadir snackbar con context
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Crear cuenta',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        const SizedBox(height: 16),

                        Row(
                          children: [
                            const Text("¿Tienes una cuenta creada?"),
                            TextButton(
                              // style: TextButton.styleFrom(
                              //   backgroundColor: Colors.white,
                              // ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (context) => LoginScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Inicia sesion ->',
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
