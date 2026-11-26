import '../../../data/repositories/reservas_repository.dart';
import '../../../domain/models/reserva.dart';

/// Prepara las reservas del usuario que ha iniciado la sesión de demostración.
///
/// Este ViewModel es de solo lectura: no mantiene selecciones ni estado cambiante.
class MisReservasViewModel {
  MisReservasViewModel({
    required ReservasRepository repository,
    required String usuarioId,
  })  : _repository = repository,
        _usuarioId = usuarioId;

  // Dependencia que conserva las reservas de la aplicación.
  final ReservasRepository _repository;

  // Identificador del usuario cuyas reservas queremos mostrar.
  final String _usuarioId;

  /// Consulta al repositorio las reservas del usuario.
  /// No conserva una segunda copia de la colección.
  List<Reserva> get reservas => _repository.obtenerPorUsuario(_usuarioId);
}
