import 'package:flutter_proyecto_reservar_espacios/domain/models/usuario.dart';

class Comentario {
  const Comentario({
    required this.id,
    required this.espacioId,
    required this.autor,
    required this.puntuacion,
    required this.texto,
    required this.fecha,
  });

  final String id;
  final String espacioId;
  final Usuario autor;
  final int puntuacion;
  final String texto;
  final DateTime fecha;
}
