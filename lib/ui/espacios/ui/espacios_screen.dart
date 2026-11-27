import 'package:flutter/material.dart';

import '../../../app_dependencies.dart';
import '../../../ui/perfil/ui/perfil_screen.dart';
import '../../../ui/reservas/ui/mis_reservas_screen.dart';
import '../view_models/detalle_espacio_view_model.dart';
import 'espacio_detalle_screen.dart';
import '../../../domain/models/espacio.dart';
import '../../../ui/core/ui/espacio_tarjeta.dart';
import '../view_models/espacios_view_model.dart';

/// Catálogo de espacios disponibles.
class EspaciosScreen extends StatelessWidget {
  const EspaciosScreen({
    super.key,
    required this.viewModel,
    required this.dependencias,
  });

  final EspaciosViewModel viewModel;

  // Dependencias compartidas para preparar las demás pantallas.
  final AppDependencies dependencias;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/pokeball.png', width: 35, height: 35),

            const SizedBox(width: 10),

            const Text('Explorar Kalos'),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Mis reservas',
            onPressed: () {
              // Abrimos las reservas del usuario de demostración.
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
            icon: const Icon(Icons.calendar_month_outlined),
          ),
          IconButton(
            tooltip: 'Mi perfil',
            onPressed: () {
              // Abrimos el perfil utilizando su ViewModel compartido.
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PerfilScreen(
                    viewModel: dependencias.perfilViewModel,
                    dependencias: dependencias,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.person_outline),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, child) {
          final espacios = viewModel.espaciosFiltrados;

          return Column(
            children: [
              // El texto se envía al ViewModel para filtrar la colección.
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: TextField(
                  onChanged: viewModel.cambiarBusqueda,
                  decoration: const InputDecoration(
                    hintText: 'Buscar por nombre, ubicación o actividad',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              Expanded(
                child: espacios.isEmpty
                    ? const _CatalogoVacio()
                    : LayoutBuilder(
                        builder: (context, constraints) {
                          // Ajustamos el número de columnas al ancho disponible.
                          final columnas = constraints.maxWidth < 560
                              ? 1
                              : constraints.maxWidth < 900
                              ? 2
                              : 3;

                          return GridView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: espacios.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: columnas,
                                  crossAxisSpacing: 14,
                                  mainAxisSpacing: 14,
                                  mainAxisExtent: 360,
                                ),
                            itemBuilder: (context, index) {
                              final Espacio espacio = espacios[index];
                              return TarjetaEspacio(
                                espacio: espacio,
                                onTap: () {
                                  // Creamos el ViewModel del detalle para el espacio seleccionado.
                                  final viewModel = DetalleEspacioViewModel(
                                    espacioId: espacio.id,
                                    espaciosRepository:
                                        dependencias.espaciosRepository,
                                    comentariosRepository:
                                        dependencias.comentariosRepository,
                                    disponibilidadRepository:
                                        dependencias.disponibilidadRepository,
                                    usuarioActual: dependencias
                                        .usuariosRepository
                                        .obtenerUsuarioDemo(),
                                  );

                                  // Abrimos el detalle pasando su ViewModel y las dependencias.
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetalleEspacioScreen(
                                            viewModel: viewModel,
                                            dependencias: dependencias,
                                          ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Mensaje reutilizable cuando la búsqueda no encuentra espacios.
class _CatalogoVacio extends StatelessWidget {
  const _CatalogoVacio();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off, size: 44),
            SizedBox(height: 12),
            Text('No se han encontrado espacios.'),
          ],
        ),
      ),
    );
  }
}
