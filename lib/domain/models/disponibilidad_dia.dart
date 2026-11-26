import 'package:flutter_proyecto_reservar_espacios/domain/models/franja_disponibilidad.dart';

class DisponibilidadDia {
  const DisponibilidadDia({
    required this.espacioId,
    required this.fecha,
    required this.franjas,
  });

  final String espacioId;
  final DateTime fecha;
  final List<FranjaDisponibilidad> franjas;
}
