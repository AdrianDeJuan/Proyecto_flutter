import 'package:flutter/foundation.dart';
import '../../../data/repositories/comentarios_repository.dart';
import '../../../data/repositories/disponibilidad_repository.dart';
import '../../../data/repositories/espacios_repository.dart';
import '../../../domain/models/comentario.dart';
import '../../../domain/models/disponibilidad_dia.dart';
import '../../../domain/models/espacio.dart';
import '../../../domain/models/usuario.dart';

/// Prepara la información que se muestra en el detalle de un espacio.
class DetalleEspacioViewModel extends ChangeNotifier {
  DetalleEspacioViewModel({
    required String espacioId,
    required EspaciosRepository espaciosRepository,
    required ComentariosRepository comentariosRepository,
    required DisponibilidadRepository disponibilidadRepository,
    required Usuario usuarioActual,
  })  : _espacioId = espacioId,
        _espaciosRepository = espaciosRepository,
        _comentariosRepository = comentariosRepository,
        _disponibilidadRepository = disponibilidadRepository,
        _usuarioActual = usuarioActual;

  final String _espacioId;
  final EspaciosRepository _espaciosRepository;
  final ComentariosRepository _comentariosRepository;
  final DisponibilidadRepository _disponibilidadRepository;
  final Usuario _usuarioActual;

  // La vista obtiene los datos directamente desde los repositorios.
  // Así evitamos mantener copias paralelas de la misma información.
  Espacio? get espacio => _espaciosRepository.obtenerPorId(_espacioId);

  List<Comentario> get comentarios =>
      _comentariosRepository.obtenerPorEspacio(_espacioId);

  List<DisponibilidadDia> get disponibilidad =>
      _disponibilidadRepository.obtenerSieteDias(_espacioId);

  /// La media se calcula a partir de los comentarios del repositorio.
  double get puntuacionMedia => _comentariosRepository.obtenerMedia(_espacioId);

  /// Número total de opiniones del espacio.
  int get numeroOpiniones => comentarios.length;

  /// Añade una opinión de demostración a la colección en memoria.
  void agregarComentario({required String texto, required int puntuacion}) {
    final espacioActual = espacio;
    if (espacioActual == null || texto.trim().isEmpty) return;

    final comentario = Comentario(
      id: 'co_${DateTime.now().microsecondsSinceEpoch}',
      espacioId: espacioActual.id,
      autor: _usuarioActual,
      puntuacion: puntuacion,
      texto: texto.trim(),
      fecha: DateTime.now(),
    );

    // El repositorio conserva la opinión y notificamos a la vista para actualizarla.
    _comentariosRepository.agregarComentario(comentario);
    notifyListeners();
  }
}
