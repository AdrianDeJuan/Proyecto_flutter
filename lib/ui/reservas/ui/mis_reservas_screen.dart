import 'package:flutter/material.dart';
import '../../../app_dependencies.dart';
import '../../../ui/perfil/ui/perfil_screen.dart';
import '../../../ui/espacios/ui/espacio_detalle_screen.dart';
import '../../../ui/espacios/view_models/detalle_espacio_view_model.dart';

import '../../../domain/models/reserva.dart';
import '../../../ui/core/ui/etiqueta_estado_reserva.dart';
import '../../../ui/core/ui/tarjeta_seccion.dart';
import '../../../utils/formato_utils.dart';
import '../view_models/mis_reservas_view_model.dart';

/// Muestra las reservas del usuario de demostración.
class MisReservasScreen extends StatelessWidget {
  const MisReservasScreen({
    super.key,
    required this.viewModel,
    required this.dependencias,
  });

  // La pantalla recibe el ViewModel que prepara las reservas.
  final MisReservasViewModel viewModel;

  // Dependencias compartidas para abrir otras pantallas.
  final AppDependencies dependencias;

  @override
  Widget build(BuildContext context) {
    // Consultamos las reservas al ViewModel al construir la pantalla.
    // Después de confirmar una reserva se vuelve a esta ruta y se lee la lista actualizada.
    final reservas = viewModel.reservas;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis reservas'),
        actions: [
          IconButton(
            tooltip: 'Perfil',
            onPressed: () {
              // Abrimos el perfil del usuario de demostración.
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
      body: reservas.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.event_busy_outlined, size: 48),
                    SizedBox(height: 12),
                    Text('Todavía no tienes reservas.'),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: reservas.length,
              itemBuilder: (context, index) {
                final reserva = reservas[index];
                return _TarjetaReserva(
                  reserva: reserva,
                  dependencias: dependencias,
                );
              },
            ),
    );
  }
}

/// Tarjeta reutilizable para una reserva concreta.
class _TarjetaReserva extends StatelessWidget {
  const _TarjetaReserva({
    required this.reserva,
    required this.dependencias,
  });

  final Reserva reserva;
  final AppDependencies dependencias;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    reserva.espacio.nombre,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                EtiquetaEstadoReserva(estado: reserva.estado),
              ],
            ),
            const SizedBox(height: 8),
            TarjetaSeccion(
              titulo: 'Detalles',
              child: Column(
                children: [
                  _FilaReserva(
                    etiqueta: 'Actividad',
                    valor: reserva.actividad,
                  ),
                  _FilaReserva(
                    etiqueta: 'Fecha',
                    valor: formatearFecha(reserva.inicio),
                  ),
                  _FilaReserva(
                    etiqueta: 'Horario',
                    valor: '${formatearHora(reserva.inicio)} – ${formatearHora(reserva.fin)}',
                  ),
                  _FilaReserva(
                    etiqueta: 'Asistentes',
                    valor: '${reserva.asistentes}',
                  ),
                  _FilaReserva(
                    etiqueta: 'Total',
                    valor: formatearPrecio(reserva.precioTotalCentimos, reserva.moneda),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton.icon(
                onPressed: () {
                  // Creamos el ViewModel del espacio relacionado con esta reserva.
                  final viewModel = DetalleEspacioViewModel(
                    espacioId: reserva.espacio.id,
                    espaciosRepository: dependencias.espaciosRepository,
                    comentariosRepository: dependencias.comentariosRepository,
                    disponibilidadRepository: dependencias.disponibilidadRepository,
                    usuarioActual: dependencias.usuariosRepository.obtenerUsuarioDemo(),
                  );

                  // Abrimos el detalle del espacio seleccionado.
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetalleEspacioScreen(
                        viewModel: viewModel,
                        dependencias: dependencias,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.visibility_outlined),
                label: const Text('Ver espacio'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Fila de texto para presentar un dato de la reserva.
class _FilaReserva extends StatelessWidget {
  const _FilaReserva({required this.etiqueta, required this.valor});

  final String etiqueta;
  final String valor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 95, child: Text(etiqueta, style: const TextStyle(color: Colors.black54))),
          Expanded(child: Text(valor)),
        ],
      ),
    );
  }
}
