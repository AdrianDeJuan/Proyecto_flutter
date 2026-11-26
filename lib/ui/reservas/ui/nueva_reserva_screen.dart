import 'package:flutter/material.dart';
import '../../../app_dependencies.dart';
import '../../../domain/models/reserva.dart';
import 'confirmacion_reserva_screen.dart';
import '../view_models/confirmacion_reserva_view_model.dart';

import '../../../domain/models/franja_disponibilidad.dart';
import '../../../ui/core/ui/tarjeta_seccion.dart';
import '../../../utils/formato_utils.dart';
import '../view_models/nueva_reserva_view_model.dart';

/// Formulario de una reserva de demostración.
class NuevaReservaScreen extends StatefulWidget {
  const NuevaReservaScreen({
    super.key,
    required this.viewModel,
    required this.dependencias,
  });

  final NuevaReservaViewModel viewModel;

  // Dependencias compartidas que necesita la pantalla de confirmación.
  final AppDependencies dependencias;

  @override
  State<NuevaReservaScreen> createState() => _NuevaReservaScreenState();
}

class _NuevaReservaScreenState extends State<NuevaReservaScreen> {
  late final NuevaReservaViewModel _viewModel;
  @override
  void initState() {
    super.initState();
    // El ViewModel llega preparado desde fuera junto con la pantalla.
    _viewModel = widget.viewModel;
  }

  @override
  void dispose() {
    // Liberamos el ViewModel cuando abandonamos el formulario.
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final espacio = _viewModel.espacio;
    if (espacio == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Nueva reserva')),
        body: const Center(child: Text('No se ha encontrado el espacio.')),
      );
    }

    final espacioActual = espacio;

    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('Nueva reserva')),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Resumen del espacio que se va a reservar.
              Card(
                clipBehavior: Clip.antiAlias,
                child: Row(
                  children: [
                    SizedBox(
                      width: 112,
                      height: 112,
                      child: Image.asset(
                        espacioActual.imagenAsset,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const ColoredBox(
                          color: Color(0xFFE7EEF1),
                          child: Icon(Icons.meeting_room_outlined, size: 38),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(espacioActual.nombre, style: Theme.of(context).textTheme.titleLarge),
                            const SizedBox(height: 5),
                            Text(espacioActual.ubicacion, maxLines: 2, overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 5),
                            Text('${espacioActual.aforo} personas · ${formatearPrecio(espacioActual.precioHoraCentimos, espacioActual.moneda)}/h'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              TarjetaSeccion(
                titulo: 'Datos de la reserva',
                icono: Icons.event_note_outlined,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Actividad: solo aparecen las admitidas por el espacio.
                        DropdownButtonFormField<String>(
                          value: _viewModel.actividad,
                          decoration: const InputDecoration(
                            labelText: 'Actividad',
                            prefixIcon: Icon(Icons.event_outlined),
                          ),
                          items: espacioActual.actividades.map((actividad) {
                            return DropdownMenuItem(
                              value: actividad,
                              child: Text(actividad),
                            );
                          }).toList(),
                          onChanged: _viewModel.cambiarActividad,
                        ),
                        const SizedBox(height: 14),

                        // Fecha: solo se ofrecen los siete días de disponibilidad.
                        DropdownButtonFormField<DateTime>(
                          value: _viewModel.fecha,
                          decoration: const InputDecoration(
                            labelText: 'Día de la reserva',
                            prefixIcon: Icon(Icons.calendar_today_outlined),
                          ),
                          items: _viewModel.diasDisponibles.map((dia) {
                            return DropdownMenuItem(
                              value: normalizarFecha(dia.fecha),
                              child: Text(formatearDiaFecha(dia.fecha)),
                            );
                          }).toList(),
                          onChanged: (fecha) {
                            if (fecha != null) _viewModel.cambiarFecha(fecha);
                          },
                        ),
                        const SizedBox(height: 14),

                        // Hora: las franjas ocupadas no se pueden seleccionar.
                        DropdownButtonFormField<FranjaDisponibilidad>(
                          value: _viewModel.franja,
                          decoration: const InputDecoration(
                            labelText: 'Horario disponible',
                            prefixIcon: Icon(Icons.access_time_outlined),
                          ),
                          items: _viewModel.franjasDelDia
                              .where((franja) => franja.disponible)
                              .map((franja) {
                            return DropdownMenuItem(
                              value: franja,
                              child: Text('${formatearHora(franja.inicio)} – ${formatearHora(franja.fin)}'),
                            );
                          }).toList(),
                          onChanged: _viewModel.cambiarFranja,
                        ),
                        const SizedBox(height: 18),

                        // Control sencillo para indicar el número de asistentes.
                        Row(
                          children: [
                            const Expanded(child: Text('Número de asistentes')),
                            IconButton(
                              tooltip: 'Quitar asistente',
                              onPressed: _viewModel.asistentes > 1
                                  ? () => _viewModel.cambiarAsistentes(_viewModel.asistentes - 1)
                                  : null,
                              icon: const Icon(Icons.remove_circle_outline),
                            ),
                            Text('${_viewModel.asistentes}', style: Theme.of(context).textTheme.titleMedium),
                            IconButton(
                              tooltip: 'Añadir asistente',
                              onPressed: _viewModel.asistentes < espacioActual.aforo
                                  ? () => _viewModel.cambiarAsistentes(_viewModel.asistentes + 1)
                                  : null,
                              icon: const Icon(Icons.add_circle_outline),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Aforo máximo: ${espacioActual.aforo} personas',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              TarjetaSeccion(
                titulo: 'Servicios adicionales',
                icono: Icons.add_circle_outline,
                child: Card(
                  child: Column(
                    children: espacioActual.serviciosDisponibles.map((servicio) {
                      final seleccionado = _viewModel.serviciosSeleccionados
                          .any((elemento) => elemento.id == servicio.id);
                      return CheckboxListTile(
                        value: seleccionado,
                        onChanged: (valor) => _viewModel.alternarServicio(
                          servicio.id,
                          valor ?? false,
                        ),
                        title: Text(servicio.nombre),
                        subtitle: Text(servicio.descripcion),
                        secondary: Text(
                          formatearPrecio(servicio.precioCentimos, espacioActual.moneda),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                      );
                    }).toList(),
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
                        _FilaPrecio(
                          concepto: 'Alquiler (${_viewModel.horasReserva} h)',
                          importe: formatearPrecio(_viewModel.precioBaseCentimos, espacioActual.moneda),
                        ),
                        const SizedBox(height: 8),
                        ..._viewModel.serviciosSeleccionados.map((servicio) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: _FilaPrecio(
                              concepto: servicio.nombre,
                              importe: formatearPrecio(servicio.precioCentimos, espacioActual.moneda),
                            ),
                          );
                        }),
                        const Divider(height: 22),
                        _FilaPrecio(
                          concepto: 'Total',
                          importe: formatearPrecio(_viewModel.precioTotalCentimos, espacioActual.moneda),
                          destacado: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              TarjetaSeccion(
                titulo: 'Contacto del espacio',
                icono: Icons.contact_phone_outlined,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.person_outline),
                          title: const Text('Responsable'),
                          subtitle: Text(espacioActual.contacto.nombre),
                        ),
                        ListTile(
                          leading: const Icon(Icons.phone_outlined),
                          title: const Text('Teléfono'),
                          subtitle: Text(espacioActual.contacto.telefono),
                        ),
                        ListTile(
                          leading: const Icon(Icons.email_outlined),
                          title: const Text('Correo'),
                          subtitle: Text(espacioActual.contacto.correo),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
              FilledButton.icon(
                // La acción crea una reserva en memoria y abre la confirmación.
                onPressed: _viewModel.puedeConfirmar
                    ? () {
                        // El ViewModel crea la reserva y la guarda en memoria.
                        final Reserva reserva = _viewModel.confirmar();

                        // Creamos el ViewModel de confirmación con la reserva recién creada.
                        final viewModel = ConfirmacionReservaViewModel(
                          reserva: reserva,
                        );

                        // Abrimos la confirmación encima del formulario.
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ConfirmacionReservaScreen(
                              viewModel: viewModel,
                              dependencias: widget.dependencias,
                            ),
                          ),
                        );
                      }
                    : null,
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Confirmar reserva'),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }
}

/// Fila de un concepto y su importe en el resumen económico.
class _FilaPrecio extends StatelessWidget {
  const _FilaPrecio({
    required this.concepto,
    required this.importe,
    this.destacado = false,
  });

  final String concepto;
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
        Expanded(child: Text(concepto, style: estilo)),
        const SizedBox(width: 12),
        Text(importe, style: estilo),
      ],
    );
  }
}
