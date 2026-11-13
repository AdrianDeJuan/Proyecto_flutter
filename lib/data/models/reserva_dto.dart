import 'package:flutter_proyecto_reservar_espacios/data/models/servicio_contratado_dto.dart';

enum EstadoReserva { confirmada, pendiente, cancelada }

class ReservaDto {
  const ReservaDto({
    required this.id,
    required this.espacioId,
    required this.usuarioId,
    required this.actividad,
    required this.inicioIso,
    required this.finIso,
    required this.asistentes,
    required this.codigoEstado,
    required this.serviciosContratados,
    required this.tarifaHoraCentimos,
    required this.precioTotalCentimos,
    required this.moneda,
  });
  //Los parametros cambian, en vez de nombrar a la clase son ids que referencian a la clase como si fuera la base de datos
  final String id;
  final String espacioId;
  final String usuarioId;
  final String actividad;
  final String inicioIso;
  final String finIso;
  final int asistentes;
  final String codigoEstado;
  final List<ServicioContratadoDto> serviciosContratados;
  final int tarifaHoraCentimos;
  final int precioTotalCentimos;
  final String moneda;
}
