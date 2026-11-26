import 'package:flutter/material.dart';
import '../../../domain/models/reserva.dart';

/// Muestra el estado de una reserva con un color coherente.
class EtiquetaEstadoReserva extends StatelessWidget {
  const EtiquetaEstadoReserva({
    super.key,
    required this.estado,
  });

  final EstadoReserva estado;

  @override
  Widget build(BuildContext context) {
    // Elegimos el texto y el color según el estado de la reserva.
    late final String texto;
    late final MaterialColor color;

    switch (estado) {
      case EstadoReserva.confirmada:
        texto = 'Confirmada';
        color = Colors.green;
        break;
      case EstadoReserva.pendiente:
        texto = 'Pendiente';
        color = Colors.orange;
        break;
      case EstadoReserva.cancelada:
        texto = 'Cancelada';
        color = Colors.red;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        texto,
        style: TextStyle(
          color: color.shade700,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
