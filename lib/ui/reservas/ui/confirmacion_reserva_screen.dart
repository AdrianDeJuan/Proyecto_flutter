import 'package:flutter/material.dart';
import '../../../app_dependencies.dart';
import 'mis_reservas_screen.dart';

import '../../../domain/models/reserva.dart';
import '../view_models/confirmacion_reserva_view_model.dart';
import '../../../ui/core/ui/etiqueta_estado_reserva.dart';
import '../../../ui/core/ui/fila_informacion.dart';
import '../../../ui/core/ui/tarjeta_seccion.dart';
import '../../../utils/formato_utils.dart';

/// Pantalla que resume la reserva recién creada.
class ConfirmacionReservaScreen extends StatelessWidget {
  const ConfirmacionReservaScreen({
    super.key,
    required this.viewModel,
    required this.dependencias,
  });

  final ConfirmacionReservaViewModel viewModel;

  // Dependencias compartidas para acceder a las reservas del usuario.
  final AppDependencies dependencias;

  Reserva get reserva => viewModel.reserva;

  @override
  Widget build(BuildContext context) {
    final duracion = viewModel.duracionHoras;

    return Scaffold(
      appBar: AppBar(title: const Text('Confirmación de reserva')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 58),
                  const SizedBox(height: 12),
                  Text(
                    'Reserva registrada',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'La solicitud se ha añadido a tus reservas de demostración.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  EtiquetaEstadoReserva(estado: reserva.estado),
                  const SizedBox(height: 8),
                  Text('Referencia: ${reserva.id}'),
                ],
              ),
            ),
          ),
          TarjetaSeccion(
            titulo: 'Datos de la reserva',
            icono: Icons.event_note_outlined,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    FilaInformacion(
                      icono: Icons.meeting_room_outlined,
                      etiqueta: 'Espacio',
                      valor: reserva.espacio.nombre,
                    ),
                    FilaInformacion(
                      icono: Icons.event_outlined,
                      etiqueta: 'Actividad',
                      valor: reserva.actividad,
                    ),
                    FilaInformacion(
                      icono: Icons.calendar_today_outlined,
                      etiqueta: 'Fecha',
                      valor: formatearFecha(reserva.inicio),
                    ),
                    FilaInformacion(
                      icono: Icons.access_time_outlined,
                      etiqueta: 'Horario',
                      valor: '${formatearHora(reserva.inicio)} – ${formatearHora(reserva.fin)} ($duracion h)',
                    ),
                    FilaInformacion(
                      icono: Icons.people_outline,
                      etiqueta: 'Asistentes',
                      valor: '${reserva.asistentes}',
                    ),
                    FilaInformacion(
                      icono: Icons.person_outline,
                      etiqueta: 'Usuario',
                      valor: reserva.usuario.nombre,
                    ),
                  ],
                ),
              ),
            ),
          ),
          TarjetaSeccion(
            titulo: 'Desglose del precio',
            icono: Icons.receipt_long_outlined,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _FilaImporte(
                      titulo: 'Alquiler ($duracion h)',
                      importe: formatearPrecio(
                        viewModel.importeAlquilerCentimos,
                        reserva.moneda,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...reserva.serviciosContratados.map((servicio) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _FilaImporte(
                          titulo: servicio.nombre,
                          importe: formatearPrecio(servicio.precioCentimos, reserva.moneda),
                        ),
                      );
                    }),
                    const Divider(height: 22),
                    _FilaImporte(
                      titulo: 'Total',
                      importe: formatearPrecio(reserva.precioTotalCentimos, reserva.moneda),
                      destacado: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () {
              // Abrimos las reservas para consultar la reserva recién creada.
              Navigator.pushReplacement(
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
            label: const Text('Ver mis reservas'),
          ),
          TextButton(
            onPressed: () {
              // Volvemos a la primera pantalla de la zona principal: el catálogo.
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: const Text('Volver al catálogo'),
          ),
        ],
      ),
    );
  }
}

/// Fila local para mostrar conceptos del desglose.
class _FilaImporte extends StatelessWidget {
  const _FilaImporte({
    required this.titulo,
    required this.importe,
    this.destacado = false,
  });

  final String titulo;
  final String importe;
  final bool destacado;

  @override
  Widget build(BuildContext context) {
    final estilo = TextStyle(
      fontWeight: destacado ? FontWeight.bold : FontWeight.normal,
      fontSize: destacado ? 17 : 14,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(titulo, style: estilo)),
        const SizedBox(width: 12),
        Text(importe, style: estilo),
      ],
    );
  }
}
