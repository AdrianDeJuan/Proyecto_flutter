import 'package:flutter_proyecto_reservar_espacios/domain/models/servicio_extra.dart';
import 'package:flutter_proyecto_reservar_espacios/domain/models/contacto_local.dart';

class Espacio {
  const Espacio({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.ubicacion,
    required this.horario,
    required this.condicionesUso,
    required this.aforo,
    required this.imagenAsset,
    required this.imagenesAssets,
    required this.sitioWeb,
    required this.serviciosDisponibles,
    required this.actividades,
    required this.equipamiento,
    required this.precioHoraCentimos,
    required this.moneda,
    required this.contacto,
  });

  final String id;
  final String nombre;
  final String descripcion;
  final String ubicacion;
  final String horario;
  final String condicionesUso;
  final int aforo;
  final String imagenAsset;
  final List<String> imagenesAssets;
  final String? sitioWeb;
  final List<ServicioExtra> serviciosDisponibles;
  final List<String> actividades;
  final List<String> equipamiento;
  final int precioHoraCentimos;
  final String moneda;
  final ContactoLocal contacto;
}
