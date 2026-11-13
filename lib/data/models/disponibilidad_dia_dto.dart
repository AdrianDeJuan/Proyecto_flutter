import 'package:flutter_proyecto_reservar_espacios/data/models/franja_disponibilidad_dto.dart';

class DisponibilidadDiaDto {
  const DisponibilidadDiaDto({
    required this.espacioId,
    required this.fechaIso,
    required this.franjas,
  });

  final String espacioId;
  final String fechaIso;
  final List<FranjaDisponibilidadDto> franjas;
}
