import 'package:flutter/foundation.dart';
import '../../../data/repositories/espacios_repository.dart';
import '../../../domain/models/espacio.dart';

/// Prepara la lista de espacios que necesita la pantalla del catálogo.
class EspaciosViewModel extends ChangeNotifier {
  EspaciosViewModel({required EspaciosRepository repository})
      : _repository = repository;

  final EspaciosRepository _repository;
  String _busqueda = '';

  /// La vista recibe los espacios directamente desde el repositorio.
  List<Espacio> get espacios => _repository.obtenerTodos();

  /// Devuelve los espacios que coinciden con el texto de búsqueda.
  List<Espacio> get espaciosFiltrados {
    final texto = _busqueda.trim().toLowerCase();
    if (texto.isEmpty) return espacios;

    return List.unmodifiable(
      espacios.where((espacio) {
        return espacio.nombre.toLowerCase().contains(texto) ||
            espacio.ubicacion.toLowerCase().contains(texto) ||
            espacio.actividades.any(
              (actividad) => actividad.toLowerCase().contains(texto),
            );
      }),
    );
  }

  /// Actualiza el texto de búsqueda y avisa a la vista.
  void cambiarBusqueda(String texto) {
    _busqueda = texto;
    notifyListeners();
  }
}
