import 'package:flutter/material.dart';
import 'package:flutter_proyecto_reservar_espacios/app_theme.dart';
import 'package:flutter_proyecto_reservar_espacios/utils/imagen_decorativa.dart';

import '../../../app_dependencies.dart';
import '../../espacios/ui/espacios_screen.dart';
import 'registro_screen.dart';

/// Pantalla de acceso de demostración.
/// No autentica contra un servidor: permite entrar al catálogo.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, required this.dependencias});

  // Recibimos las dependencias creadas al iniciar la aplicación.
  final AppDependencies dependencias;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Utilizamos Stack para colocar una imagen detrás del contenido.
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Imagen de fondo que ocupa toda la pantalla.
          Image.asset('assets/images/Mapa_Kalos.png', fit: BoxFit.fill),

          // Contenido del Login por encima de la imagen de fondo.
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
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
                          // Imagen principal del Login.
                          // ClipRRect(
                          //   borderRadius: BorderRadius.circular(12),
                          //   child: Image.asset(
                          //     'assets/images/login.jpg',
                          //     width: double.infinity,
                          //     height: 160,
                          //     fit: BoxFit.cover,
                          //   ),
                          // ),

                          const SizedBox(height: 16),

                          // Título de la aplicación.
                          // Imagen y título colocados horizontalmente.
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
                                  'Inicia Sesion',
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

                          const SizedBox(height: 8),

                          const Text(
                            'Encuentra el espacio adecuado para tu actividad.',
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 28),

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

                          const SizedBox(height: 22),

                          // Botón de acceso simulado.
                          FilledButton(
                            onPressed: () {
                              // Abrimos el catálogo y eliminamos
                              // las rutas anteriores.
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

                          const SizedBox(height: 16),

                          // Botón de acceso con Google.
                          // Es únicamente visual, no realiza autenticación.
                          Row(
                            children: [
                              // Botón de Google.
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EspaciosScreen(
                                          viewModel:
                                              dependencias.espaciosViewModel,
                                          dependencias: dependencias,
                                        ),
                                      ),
                                      (route) => false,
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.g_mobiledata,
                                    size: 26,
                                  ),
                                  label: const Text('Google'),
                                ),
                              ),

                              const SizedBox(width: 16),

                              // Botón de Apple.
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EspaciosScreen(
                                          viewModel:
                                              dependencias.espaciosViewModel,
                                          dependencias: dependencias,
                                        ),
                                      ),
                                      (route) => false,
                                    );
                                  },
                                  icon: const Icon(Icons.phone_iphone_outlined),
                                  label: const Text('Apple'),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Acceso al formulario de registro.
                          TextButton(
                            onPressed: () {
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
        ],
      ),
    );
  }
}
