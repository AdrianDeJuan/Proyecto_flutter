import 'package:flutter/material.dart';
import '../../../app_dependencies.dart';
import '../../acceso/ui/login_screen.dart';
import '../../../ui/reservas/ui/mis_reservas_screen.dart';

import '../../../domain/models/usuario.dart';
import '../../../ui/core/ui/tarjeta_seccion.dart';
import '../../../utils/formato_utils.dart';
import '../view_models/perfil_view_model.dart';

/// Perfil del usuario de demostración y accesos a otras secciones.
class PerfilScreen extends StatelessWidget {
  const PerfilScreen({
    super.key,
    required this.viewModel,
    required this.dependencias,
  });

  // La pantalla recibe el ViewModel que prepara los datos del perfil.
  final PerfilViewModel viewModel;

  // Dependencias compartidas para navegar a otras pantallas.
  final AppDependencies dependencias;

  @override
  Widget build(BuildContext context) {
    // El ViewModel proporciona los datos; la pantalla solo los representa.
    final Usuario usuario = viewModel.usuario;

    return Scaffold(
      appBar: AppBar(title: const Text('Mi perfil')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Tarjeta superior con los datos básicos del usuario.
          Card(
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 38,
                    child: Text(
                      obtenerIniciales(usuario.nombre),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    usuario.nombre,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    usuario.correo,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),

          // Accesos a las otras partes de la aplicación.
          TarjetaSeccion(
            titulo: 'Mi actividad',
            icono: Icons.person_outline,
            child: Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.meeting_room_outlined),
                    title: const Text('Espacios disponibles'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // El catálogo es la primera pantalla tras el acceso.
                      // Volvemos a ella sin crear otra copia en la pila.
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.calendar_month_outlined),
                    title: const Text('Mis reservas'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // Abrimos la lista de reservas del usuario.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MisReservasScreen(
                            viewModel: dependencias.misReservasViewModel,
                            dependencias: dependencias,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // Preferencias visuales de ejemplo: no se guardan cambios.
          TarjetaSeccion(
            titulo: 'Preferencias',
            icono: Icons.tune,
            child: const Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.notifications_outlined),
                    title: Text('Notificaciones'),
                    trailing: Text('Activadas'),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.language),
                    title: Text('Idioma'),
                    trailing: Text('Español'),
                  ),
                ],
              ),
            ),
          ),

          // Información estática de la aplicación.
          TarjetaSeccion(
            titulo: 'Acerca de la aplicación',
            icono: Icons.info_outline,
            child: const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reserva de espacios',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Versión 1.0.0',
                      style: TextStyle(color: Colors.black54),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Aplicación para consultar espacios, conocer sus '
                      'características y gestionar reservas de demostración.',
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // La sesión es ficticia; volver al login reinicia el recorrido visual.
          OutlinedButton.icon(
            onPressed: () {
              // Cerramos la sesión simulada y limpiamos las pantallas anteriores.
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(
                    dependencias: dependencias,
                  ),
                ),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
            label: const Text('Cerrar sesión'),
            style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
          ),
        ],
      ),
    );
  }
}
