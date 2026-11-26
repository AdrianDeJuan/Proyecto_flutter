import 'package:flutter_proyecto_reservar_espacios/domain/models/espacio.dart';
import 'package:flutter_proyecto_reservar_espacios/domain/models/servicio_contratado.dart';
import 'package:flutter_proyecto_reservar_espacios/domain/models/usuario.dart';

enum EstadoReserva { confirmada, pendiente, cancelada }

class Reserva {
  const Reserva({
    required this.id,
    required this.espacio,
    required this.usuario,
    required this.actividad,
    required this.inicio,
    required this.fin,
    required this.asistentes,
    required this.estado,
    required this.serviciosContratados,
    required this.tarifaHoraCentimos,
    required this.precioTotalCentimos,
    required this.moneda,
  });

  final String id;
  final Espacio espacio;
  final Usuario usuario;
  final String actividad;
  final DateTime inicio;
  final DateTime fin;
  final int asistentes;
  final EstadoReserva estado;
  final List<ServicioContratado> serviciosContratados;
  final int tarifaHoraCentimos;
  final int precioTotalCentimos;
  final String moneda;

  Duration get duracion => fin.difference(inicio);

  int get totalServiciosCentimos => serviciosContratados.fold<int>(
    //El equivalente de un for
    0, //Indica que total empieza en 0
    (total, servicio) => total + servicio.precioCentimos,
  );
}

//Para comprobar que esta bien puesta la informacion

//final minutos = reserva.duracion.inMinutes;
// if (minutos <= 0 || minutos % 60 != 0) {
//   throw StateError('Intervalo de ejemplo no valido');
// }
// final horas = minutos ~/ 60;
// final totalEsperado =
//     reserva.tarifaHoraCentimos * horas + reserva.totalServiciosCentimos;
// if (reserva.precioTotalCentimos != totalEsperado) {
//   throw StateError('El precio no coincide con la duracion');
// }
