import '../models/comentario_dto.dart';
import '../services/datos_simulados_service.dart';
import '../../domain/models/comentario.dart';
import 'espacios_repository.dart';
import 'usuarios_repository.dart';

/// Consulta comentarios, resuelve sus autores y calcula sus valoraciones.
class ComentariosRepository {
  ComentariosRepository({
    required DatosSimuladosService service,
    required EspaciosRepository espaciosRepository,
    required UsuariosRepository usuariosRepository,
  }) {
    final comentariosDto = service.leerComentarios();

    // Comprobamos identificadores y transformamos cada comentario.
    final identificadores = <String>{};
    _comentarios.addAll(comentariosDto.map((dto) {
      if (dto.id.trim().isEmpty || !identificadores.add(dto.id)) {
        throw StateError('Hay un identificador de comentario vacío o duplicado.');
      }
      if (espaciosRepository.obtenerPorId(dto.espacioId) == null) {
        throw StateError('No existe el espacio ${dto.espacioId} del comentario ${dto.id}.');
      }

      final autor = usuariosRepository.obtenerPorId(dto.autorId);
      if (autor == null) {
        throw StateError('No existe el autor ${dto.autorId} del comentario ${dto.id}.');
      }

      if (dto.puntuacion < 1 || dto.puntuacion > 5) {
        throw FormatException('La puntuación de ${dto.id} debe estar entre 1 y 5.');
      }
      if (dto.texto.trim().isEmpty) {
        throw FormatException('El comentario ${dto.id} no contiene texto.');
      }

      return Comentario(
        id: dto.id,
        espacioId: dto.espacioId,
        autor: autor,
        puntuacion: dto.puntuacion,
        texto: dto.texto,
        fecha: DateTime.parse(dto.fechaIso),
      );
    }));
  }

  // Lista interna para poder añadir comentarios de demostración en memoria.
  final List<Comentario> _comentarios = [];

  /// Devuelve los comentarios de un espacio, ordenados del más reciente al más antiguo.
  List<Comentario> obtenerPorEspacio(String espacioId) {
    final resultado = _comentarios
        .where((comentario) => comentario.espacioId == espacioId)
        .toList()
      ..sort((a, b) => b.fecha.compareTo(a.fecha));

    return List.unmodifiable(resultado);
  }

  /// Calcula la puntuación media de las opiniones de un espacio.
  /// Devuelve 0 cuando todavía no hay comentarios.
  double obtenerMedia(String espacioId) {
    final comentarios = obtenerPorEspacio(espacioId);
    if (comentarios.isEmpty) return 0;

    final suma = comentarios.fold<int>(
      0,
      (total, comentario) => total + comentario.puntuacion,
    );
    return suma / comentarios.length;
  }

  /// Añade una opinión local a la colección en memoria.
  void agregarComentario(Comentario comentario) {
    _comentarios.add(comentario);
  }
}
