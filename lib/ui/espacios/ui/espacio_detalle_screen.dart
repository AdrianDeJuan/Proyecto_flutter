import 'package:flutter/material.dart';
import '../../../app_dependencies.dart';
import '../../../ui/reservas/ui/mis_reservas_screen.dart';
import '../../../ui/reservas/ui/nueva_reserva_screen.dart';
import '../../../ui/reservas/view_models/nueva_reserva_view_model.dart';

import '../../../domain/models/comentario.dart';
import '../../../domain/models/disponibilidad_dia.dart';
import '../../../domain/models/espacio.dart';
import '../../../domain/models/franja_disponibilidad.dart';
import '../../../ui/core/ui/fila_informacion.dart';
import '../../../ui/core/ui/tarjeta_seccion.dart';
import '../../../utils/formato_utils.dart';
import '../view_models/detalle_espacio_view_model.dart';

/// Pantalla que presenta toda la información de un espacio.
class DetalleEspacioScreen extends StatefulWidget {
  const DetalleEspacioScreen({
    super.key,
    required this.viewModel,
    required this.dependencias,
  });

  final DetalleEspacioViewModel viewModel;

  // Dependencias compartidas para abrir otras pantallas.
  final AppDependencies dependencias;

  @override
  State<DetalleEspacioScreen> createState() => _DetalleEspacioScreenState();
}

class _DetalleEspacioScreenState extends State<DetalleEspacioScreen> {
  late final DetalleEspacioViewModel _viewModel;
  late final PageController _pageController;
  final TextEditingController _comentarioController = TextEditingController();
  int _paginaActual = 0;
  int _puntuacion = 5;

  @override
  void initState() {
    super.initState();

    // La pantalla recibe el ViewModel ya conectado con sus repositorios.
    _viewModel = widget.viewModel;

    // PageController permite conocer la página visible del carrusel.
    _pageController = PageController();
  }

  @override
  void dispose() {
    // Liberamos los recursos que pertenecen a esta pantalla.
    _pageController.dispose();
    _comentarioController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, child) {
        final Espacio? espacio = _viewModel.espacio;

        if (espacio == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Espacio no encontrado')),
            body: const Center(child: Text('No existe el espacio solicitado.')),
          );
        }

        // Usamos las imágenes del espacio; si faltan, al menos mostramos la principal.
        final imagenes = espacio.imagenesAssets.isNotEmpty
            ? espacio.imagenesAssets
            : [espacio.imagenAsset];

        return Scaffold(
          appBar: AppBar(
            title: Text(espacio.nombre),
            actions: [
              IconButton(
                tooltip: 'Mis reservas',
                onPressed: () {
                  // Abrimos las reservas conservando el detalle debajo en la pila.
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MisReservasScreen(
                        viewModel: widget.dependencias.misReservasViewModel,
                        dependencias: widget.dependencias,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.calendar_month_outlined),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
            children: [
              _construirCarrusel(imagenes),
              const SizedBox(height: 22),

              // Nombre y ubicación del espacio.
              Text(
                espacio.nombre,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on_outlined, size: 20),
                  const SizedBox(width: 8),
                  Expanded(child: Text(espacio.ubicacion)),
                ],
              ),
              const SizedBox(height: 16),

              // Datos breves que ayudan a comparar espacios.
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _DatoResumen(
                    icono: Icons.people_outline,
                    etiqueta: 'Aforo',
                    valor: '${espacio.aforo} personas',
                  ),
                  _DatoResumen(
                    icono: Icons.payments_outlined,
                    etiqueta: 'Precio por hora',
                    valor: formatearPrecio(
                      espacio.precioHoraCentimos,
                      espacio.moneda,
                    ),
                  ),
                  if (espacio.etiqueta != null)
                    _DatoResumen(
                      icono: Icons.sell_outlined,
                      etiqueta: 'Etiqueta',
                      valor: _nombreEtiqueta(espacio.etiqueta!),
                    ),
                ],
              ),

              TarjetaSeccion(
                titulo: 'Descripción',
                icono: Icons.description_outlined,
                child: Text(espacio.descripcion),
              ),

              TarjetaSeccion(
                titulo: 'Actividades admitidas',
                icono: Icons.event_available_outlined,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: espacio.actividades
                      .map((actividad) => Chip(label: Text(actividad)))
                      .toList(),
                ),
              ),

              TarjetaSeccion(
                titulo: 'Equipamiento',
                icono: Icons.chair_alt_outlined,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: espacio.equipamiento.map((elemento) {
                    return Chip(
                      avatar: const Icon(Icons.check_circle_outline, size: 18),
                      label: Text(elemento),
                    );
                  }).toList(),
                ),
              ),

              TarjetaSeccion(
                titulo: 'Servicios adicionales',
                icono: Icons.add_circle_outline,
                child: Column(
                  children: espacio.serviciosDisponibles.map((servicio) {
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.add_circle_outline),
                        title: Text(servicio.nombre),
                        subtitle: Text(servicio.descripcion),
                        trailing: Text(
                          formatearPrecio(servicio.precioCentimos, espacio.moneda),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              TarjetaSeccion(
                titulo: 'Contacto local',
                icono: Icons.contact_phone_outlined,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        FilaInformacion(
                          icono: Icons.person_outline,
                          etiqueta: 'Nombre',
                          valor: espacio.contacto.nombre,
                        ),
                        FilaInformacion(
                          icono: Icons.phone_outlined,
                          etiqueta: 'Teléfono',
                          valor: espacio.contacto.telefono,
                        ),
                        FilaInformacion(
                          icono: Icons.email_outlined,
                          etiqueta: 'Correo',
                          valor: espacio.contacto.correo,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              TarjetaSeccion(
                titulo: 'Información de uso',
                icono: Icons.info_outline,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FilaInformacion(
                          icono: Icons.schedule,
                          etiqueta: 'Horario',
                          valor: espacio.horario,
                        ),
                        FilaInformacion(
                          icono: Icons.rule_outlined,
                          etiqueta: 'Condiciones',
                          valor: espacio.condicionesUso,
                        ),
                        FilaInformacion(
                          icono: Icons.language,
                          etiqueta: 'Sitio web',
                          // El requisito indica mostrar el texto, no abrir la web.
                          valor: espacio.sitioWeb ?? 'Sin sitio web',
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              TarjetaSeccion(
                titulo: 'Disponibilidad',
                icono: Icons.calendar_month_outlined,
                child: _construirDisponibilidad(_viewModel.disponibilidad),
              ),

              TarjetaSeccion(
                titulo: 'Opiniones',
                icono: Icons.star_outline,
                child: _construirOpiniones(_viewModel.comentarios),
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    // Preparamos el ViewModel con el espacio que el usuario está consultando.
                    final viewModel = NuevaReservaViewModel(
                      espacioId: espacio.id,
                      espaciosRepository: widget.dependencias.espaciosRepository,
                      usuariosRepository: widget.dependencias.usuariosRepository,
                      reservasRepository: widget.dependencias.reservasRepository,
                      disponibilidadRepository: widget.dependencias.disponibilidadRepository,
                    );

                    // Abrimos el formulario de reserva para ese espacio.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NuevaReservaScreen(
                          viewModel: viewModel,
                          dependencias: widget.dependencias,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.calendar_month),
                  label: const Text('Reservar este espacio'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Construye el carrusel y muestra un indicador que sigue la página visible.
  Widget _construirCarrusel(List<String> imagenes) {
    return Column(
      children: [
        SizedBox(
          height: 230,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: PageView.builder(
              controller: _pageController,
              itemCount: imagenes.length,
              onPageChanged: (indice) {
                setState(() => _paginaActual = indice);
              },
              itemBuilder: (context, index) {
                return Image.asset(
                  imagenes[index],
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.blueGrey.shade50,
                    alignment: Alignment.center,
                    child: const Icon(Icons.image_not_supported_outlined, size: 48),
                  ),
                );
              },
            ),
          ),
        ),
        if (imagenes.length > 1) ...[
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(imagenes.length, (indice) {
              final seleccionada = indice == _paginaActual;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: seleccionada ? 18 : 7,
                height: 7,
                decoration: BoxDecoration(
                  color: seleccionada
                      ? Theme.of(context).colorScheme.primary
                      : Colors.blueGrey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            }),
          ),
        ],
      ],
    );
  }

  // Representa las fechas y las franjas libres u ocupadas recibidas del repositorio.
  Widget _construirDisponibilidad(List<DisponibilidadDia> dias) {
    if (dias.isEmpty) {
      return const Text('No hay información de disponibilidad para estos días.');
    }

    return Column(
      children: dias.map((dia) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  formatearDiaFecha(dia.fecha),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: dia.franjas.map(_construirFranja).toList(),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // Muestra una franja usando texto y color para distinguir su disponibilidad.
  Widget _construirFranja(FranjaDisponibilidad franja) {
    final color = franja.disponible ? Colors.green : Colors.red;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.35)),
      ),
      child: Column(
        children: [
          Text('${formatearHora(franja.inicio)}–${formatearHora(franja.fin)}'),
          Text(
            franja.disponible ? 'Libre' : 'Ocupada',
            style: TextStyle(color: color.shade700, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Construye la media, las opiniones existentes y el pequeño formulario local.
  Widget _construirOpiniones(List<Comentario> comentarios) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (comentarios.isEmpty)
          const Text('Sin valoraciones')
        else ...[
          Row(
            children: [
              Text(
                _viewModel.puntuacionMedia.toStringAsFixed(1),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _construirEstrellas(_viewModel.puntuacionMedia),
                  Text('${_viewModel.numeroOpiniones} opiniones'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...comentarios.map(_TarjetaOpinion.new),
        ],
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Añadir una opinión',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: List.generate(5, (indice) {
                    final numero = indice + 1;
                    return IconButton(
                      tooltip: '$numero estrellas',
                      visualDensity: VisualDensity.compact,
                      onPressed: () => setState(() => _puntuacion = numero),
                      icon: Icon(
                        numero <= _puntuacion ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                      ),
                    );
                  }),
                ),
                TextField(
                  controller: _comentarioController,
                  minLines: 2,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Escribe tu comentario',
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton.icon(
                    onPressed: () {
                      // El ViewModel añade el comentario al repositorio en memoria.
                      _viewModel.agregarComentario(
                        texto: _comentarioController.text,
                        puntuacion: _puntuacion,
                      );
                      _comentarioController.clear();
                    },
                    icon: const Icon(Icons.send),
                    label: const Text('Publicar opinión'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Dibuja cinco estrellas y permite medias estrellas para la puntuación media.
  Widget _construirEstrellas(double puntuacion) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (indice) {
        final valor = indice + 1;
        final icono = puntuacion >= valor
            ? Icons.star
            : puntuacion > indice
                ? Icons.star_half
                : Icons.star_border;
        return Icon(icono, color: Colors.amber, size: 19);
      }),
    );
  }

  // Convierte el enum de etiqueta en un texto legible.
  String _nombreEtiqueta(EtiquetaEspacio etiqueta) {
    switch (etiqueta) {
      case EtiquetaEspacio.popular:
        return 'Popular';
      case EtiquetaEspacio.nuevo:
        return 'Nuevo';
      case EtiquetaEspacio.terraza:
        return 'Terraza';
      case EtiquetaEspacio.silencioso:
        return 'Silencioso';
      case EtiquetaEspacio.basico:
        return 'Básico';
      case EtiquetaEspacio.vip:
        return 'VIP';
    }
  }
}

/// Pequeña tarjeta con un dato resumido del espacio.
class _DatoResumen extends StatelessWidget {
  const _DatoResumen({
    required this.icono,
    required this.etiqueta,
    required this.valor,
  });

  final IconData icono;
  final String etiqueta;
  final String valor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icono, size: 18),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(etiqueta, style: Theme.of(context).textTheme.labelSmall),
              Text(valor, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}

/// Representa una opinión de un usuario.
class _TarjetaOpinion extends StatelessWidget {
  const _TarjetaOpinion(this.comentario);

  final Comentario comentario;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    comentario.autor.nombre,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  formatearFecha(comentario.fecha),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: List.generate(5, (indice) {
                return Icon(
                  indice < comentario.puntuacion ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 17,
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(comentario.texto),
          ],
        ),
      ),
    );
  }
}
