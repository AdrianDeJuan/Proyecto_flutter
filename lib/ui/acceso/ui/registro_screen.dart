import 'package:flutter/material.dart';
import 'package:flutter_proyecto_reservar_espacios/app_theme.dart';
import 'package:flutter_proyecto_reservar_espacios/utils/imagen_decorativa.dart';

/// Formulario visual de registro.
/// La entrega utiliza datos simulados, por lo que no crea usuarios persistentes.
class RegistroScreen extends StatelessWidget {
  const RegistroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Colocamos una imagen de fondo detrás del formulario.
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Imagen de fondo.
          Image.asset('assets/images/Mapa_Kalos.png', fit: BoxFit.fill),

          // Contenido del formulario por encima del fondo.
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 460),
                  child: Card(
                    // Fondo marfil para contrastar con el mapa.
                    color: AppTheme.colorFormulario,

                    // Evita que Material 3 altere el color elegido.
                    surfaceTintColor: Colors.transparent,

                    // Añade profundidad respecto al fondo.
                    elevation: 8,

                    // Bordes redondeados y detalle dorado.
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: const BorderSide(
                        color: AppTheme.colorBordeFormulario,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Imagen principal del Registro.
                          // ClipRRect(
                          //   borderRadius: BorderRadius.circular(12),
                          //   child: Image.asset(
                          //     'assets/images/registro.jpg',
                          //     width: double.infinity,
                          //     height: 160,
                          //     fit: BoxFit.cover,
                          //   ),
                          // ),

                          const SizedBox(height: 16),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const ImagenDecorativa(
                                rutaImagen: 'assets/images/pokeball.png',
                                ancho: 60,
                                opacidad: 1.0,
                              ),

                              const SizedBox(width: 8),

                              // El título ocupa todo el espacio restante.
                              Expanded(
                                child: Text(
                                  'Regístrate',
                                  textAlign: TextAlign.center,
                                  maxLines: 2, //Maximo 2 lineas antes de aplicar el overvlow
                                  overflow: TextOverflow
                                      .ellipsis, //Si alcanza el limite pone ...
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall,
                                ),
                              ),

                              const SizedBox(width: 8),

                              const ImagenDecorativa(
                                rutaImagen: 'assets/images/reshiram&zekrom.png',
                                ancho: 60,
                                opacidad: 1.0,
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // Campo de nombre completo.
                          const TextField(
                            decoration: InputDecoration(
                              labelText: 'Nombre completo',
                              prefixIcon: Icon(Icons.person_outline),
                            ),
                          ),

                          const SizedBox(height: 14),

                          // Campo de correo electrónico.
                          const TextField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Correo electrónico',
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                          ),

                          const SizedBox(height: 14),

                          // Campo de contraseña.
                          const TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Contraseña',
                              prefixIcon: Icon(Icons.lock_outline),
                            ),
                          ),

                          const SizedBox(height: 14),

                          // Campo para repetir la contraseña.
                          const TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Repetir contraseña',
                              prefixIcon: Icon(Icons.lock_outline),
                            ),
                          ),

                          const SizedBox(height: 22),

                          // Botón de registro simulado.
                          FilledButton(
                            onPressed: () {
                              // Volvemos al Login que quedó debajo.
                              Navigator.pop(context);
                            },
                            child: const Text('Crear cuenta'),
                          ),

                          const SizedBox(height: 24),

                          // Volvemos al Login.
                          TextButton(
                            onPressed: () {
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
          ),
        ],
      ),
    );
  }
}
