import '../../../domain/models/reserva.dart';

/// Expone los datos de la reserva que se acaba de confirmar.
/// No necesita notificar cambios porque esta información es de solo lectura.
class ConfirmacionReservaViewModel {
  ConfirmacionReservaViewModel({required this.reserva})
      : duracionHoras = reserva.duracion.inMinutes ~/ 60;

  final Reserva reserva;
  final int duracionHoras;

  /// Importe del alquiler sin los servicios adicionales.
  int get importeAlquilerCentimos =>
      reserva.tarifaHoraCentimos * duracionHoras;

  /// Devuelve el nombre del espacio asociado a la reserva.
  String get nombreEspacio => reserva.espacio.nombre;
}
