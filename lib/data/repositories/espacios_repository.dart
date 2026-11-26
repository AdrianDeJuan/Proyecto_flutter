import '../models/espacio_dto.dart' as datos;
import '../services/datos_simulados_service.dart';
import '../../domain/models/contacto_local.dart';
import '../../domain/models/espacio.dart' as dominio;
import '../../domain/models/servicio_extra.dart';

/// Consulta los espacios y convierte sus DTO a modelos de dominio.
class EspaciosRepository {
  EspaciosRepository({required DatosSimuladosService service}) {
    // El servicio actúa como nuestra fuente de datos de demostración.
    final espaciosDto = service.leerEspacios();

    // Comprobamos que los datos principales de origen sean coherentes.
    final identificadores = <String>{};
    for (final espacio in espaciosDto) {
      if (espacio.id.trim().isEmpty || !identificadores.add(espacio.id)) {
        throw StateError('Hay un identificador de espacio vacío o duplicado.');
      }
      if (espacio.nombre.trim().isEmpty || espacio.aforo <= 0 ||
          espacio.precioHoraCentimos < 0) {
        throw FormatException('Los datos básicos del espacio ${espacio.id} no son válidos.');
      }
    }

    // Convertimos los DTO una sola vez al crear el repositorio.
    _espacios = List.unmodifiable(espaciosDto.map(_aDominio));
  }

  // Lista privada e inmodificable desde fuera del repositorio.
  late final List<dominio.Espacio> _espacios;

  /// Devuelve todos los espacios disponibles.
  List<dominio.Espacio> obtenerTodos() => _espacios;

  /// Busca un espacio por su identificador; devuelve null si no existe.
  dominio.Espacio? obtenerPorId(String id) {
    for (final espacio in _espacios) {
      if (espacio.id == id) return espacio;
    }
    return null;
  }

  /// Convierte un DTO completo en un modelo de dominio.
  static dominio.Espacio _aDominio(datos.EspacioDto dto) {
    return dominio.Espacio(
      id: dto.id,
      nombre: dto.nombre,
      descripcion: dto.descripcion,
      ubicacion: dto.ubicacion,
      horario: dto.horario,
      condicionesUso: dto.condicionesUso,
      aforo: dto.aforo,
      imagenAsset: dto.imagenAsset,
      imagenesAssets: List.unmodifiable(dto.imagenesAssets),
      sitioWeb: dto.sitioWeb,
      serviciosDisponibles: List.unmodifiable(
        dto.serviciosDisponibles.map(
          (servicio) => ServicioExtra(
            id: servicio.id,
            nombre: servicio.nombre,
            descripcion: servicio.descripcion,
            precioCentimos: servicio.precioCentimos,
          ),
        ),
      ),
      actividades: List.unmodifiable(dto.actividades),
      equipamiento: List.unmodifiable(dto.equipamiento),
      precioHoraCentimos: dto.precioHoraCentimos,
      moneda: dto.moneda,
      contacto: ContactoLocal(
        id: dto.contacto.id,
        nombre: dto.contacto.nombre,
        telefono: dto.contacto.telefono,
        correo: dto.contacto.correo,
      ),
      destacado: dto.destacado,
      etiqueta: _convertirEtiqueta(dto.etiqueta),
    );
  }

  /// Convierte el enum de datos al enum equivalente del dominio.
  static dominio.EtiquetaEspacio? _convertirEtiqueta(
    datos.EtiquetaEspacio? etiqueta,
  ) {
    if (etiqueta == null) return null;

    switch (etiqueta) {
      case datos.EtiquetaEspacio.popular:
        return dominio.EtiquetaEspacio.popular;
      case datos.EtiquetaEspacio.nuevo:
        return dominio.EtiquetaEspacio.nuevo;
      case datos.EtiquetaEspacio.terraza:
        return dominio.EtiquetaEspacio.terraza;
      case datos.EtiquetaEspacio.silencioso:
        return dominio.EtiquetaEspacio.silencioso;
      case datos.EtiquetaEspacio.basico:
        return dominio.EtiquetaEspacio.basico;
      case datos.EtiquetaEspacio.vip:
        return dominio.EtiquetaEspacio.vip;
    }
  }
}
