import '../models/disponibilidad_dia_dto.dart';
import '../services/datos_simulados_service.dart';
import '../../domain/models/disponibilidad_dia.dart';
import '../../domain/models/franja_disponibilidad.dart';
import 'espacios_repository.dart';

/// Consulta y convierte las disponibilidades de cada espacio.
class DisponibilidadRepository {
  DisponibilidadRepository({
    required DatosSimuladosService service,
    required EspaciosRepository espaciosRepository,
  }) {
    final disponibilidadDto = service.leerDisponibilidad();

    // Comprobamos que no se repita el mismo día para un mismo espacio.
    final diasRegistrados = <String>{};

    // Convertimos los días y comprobamos que su espacio exista.
    _dias.addAll(
      disponibilidadDto.map((dto) {
        if (espaciosRepository.obtenerPorId(dto.espacioId) == null) {
          throw StateError(
            'No existe el espacio ${dto.espacioId} de la disponibilidad.',
          );
        }

        final fecha = DateTime.parse(dto.fechaIso);
        final claveDia =
            '${dto.espacioId}_${fecha.year}-${fecha.month}-${fecha.day}';
        if (!diasRegistrados.add(claveDia)) {
          throw StateError('Hay una disponibilidad duplicada para $claveDia.');
        }

        return DisponibilidadDia(
          espacioId: dto.espacioId,
          fecha: fecha,
          franjas: List.unmodifiable(
            dto.franjas.map((franjaDto) {
              final inicio = DateTime.parse(franjaDto.inicioIso);
              final fin = DateTime.parse(franjaDto.finIso);
              if (!fin.isAfter(inicio)) {
                throw const FormatException(
                  'Se ha recibido una franja horaria no válida.',
                );
              }

              return FranjaDisponibilidad(
                inicio: inicio,
                fin: fin,
                disponible: franjaDto.disponible,
              );
            }),
          ),
        );
      }),
    );
  }

  // Lista interna para poder actualizar una franja después de reservarla.
  final List<DisponibilidadDia> _dias = [];

  /// Devuelve hoy y los seis días siguientes para un espacio.
  List<DisponibilidadDia> obtenerSieteDias(String espacioId) {
    final hoy = DateTime.now();
    final inicio = DateTime(hoy.year, hoy.month, hoy.day);
    final fin = inicio.add(const Duration(days: 7));

    final resultado = _dias.where((dia) {
      return dia.espacioId == espacioId &&
          !dia.fecha.isBefore(inicio) &&
          dia.fecha.isBefore(fin);
    }).toList()..sort((a, b) => a.fecha.compareTo(b.fecha));

    return List.unmodifiable(resultado);
  }

  /// Busca la disponibilidad de un espacio en una fecha concreta.
  DisponibilidadDia? obtenerPorFecha(String espacioId, DateTime fecha) {
    for (final dia in _dias) {
      final mismaFecha =
          dia.fecha.year == fecha.year &&
          dia.fecha.month == fecha.month &&
          dia.fecha.day == fecha.day;
      if (dia.espacioId == espacioId && mismaFecha) return dia;
    }
    return null;
  }

  /// Marca como ocupada una franja que acaba de reservarse.
  void marcarOcupada(String espacioId, DateTime inicio, DateTime fin) {
    final indice = _dias.indexWhere((dia) {
      return dia.espacioId == espacioId &&
          dia.fecha.year == inicio.year &&
          dia.fecha.month == inicio.month &&
          dia.fecha.day == inicio.day;
    });

    if (indice == -1) return;

    final dia = _dias[indice];
    final franjasActualizadas = dia.franjas.map((franja) {
      if (franja.inicio == inicio && franja.fin == fin) {
        return FranjaDisponibilidad(
          inicio: franja.inicio,
          fin: franja.fin,
          disponible: false,
        );
      }
      return franja;
    }).toList();

    _dias[indice] = DisponibilidadDia(
      espacioId: dia.espacioId,
      fecha: dia.fecha,
      franjas: List.unmodifiable(franjasActualizadas),
    );
  }
}
