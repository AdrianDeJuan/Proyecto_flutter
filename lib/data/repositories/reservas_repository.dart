import '../models/reserva_dto.dart' as datos;
import '../services/datos_simulados_service.dart';
import '../../domain/models/reserva.dart' as dominio;
import '../../domain/models/servicio_contratado.dart';
import 'espacios_repository.dart';
import 'usuarios_repository.dart';

/// Consulta las reservas y resuelve sus referencias a espacios y usuarios.
class ReservasRepository {
  ReservasRepository({
    required DatosSimuladosService service,
    required EspaciosRepository espaciosRepository,
    required UsuariosRepository usuariosRepository,
  }) {
    final reservasDto = service.leerReservas();

    // Los DTO guardan IDs; aquí comprobamos que las referencias existan.
    final identificadores = <String>{};
    for (final dto in reservasDto) {
      if (dto.id.trim().isEmpty || !identificadores.add(dto.id)) {
        throw StateError('Hay un identificador de reserva vacío o duplicado.');
      }
      _reservas.add(_aDominio(dto, espaciosRepository, usuariosRepository));
    }
  }

  // La lista se mantiene dentro del repositorio para conservar las reservas
  // añadidas durante la ejecución de la aplicación.
  final List<dominio.Reserva> _reservas = [];

  /// Devuelve las reservas de un usuario concreto.
  List<dominio.Reserva> obtenerPorUsuario(String usuarioId) {
    final resultado = _reservas
        .where((reserva) => reserva.usuario.id == usuarioId)
        .toList()
      ..sort((a, b) => b.inicio.compareTo(a.inicio));

    return List.unmodifiable(resultado);
  }

  /// Busca una reserva por su identificador.
  dominio.Reserva? obtenerPorId(String id) {
    for (final reserva in _reservas) {
      if (reserva.id == id) return reserva;
    }
    return null;
  }

  /// Añade una reserva a la lista en memoria (no guarda en una base de datos).
  void agregarReserva(dominio.Reserva reserva) {
    _reservas.add(reserva);
  }

  /// Convierte una ReservaDto y resuelve sus relaciones.
  static dominio.Reserva _aDominio(
    datos.ReservaDto dto,
    EspaciosRepository espaciosRepository,
    UsuariosRepository usuariosRepository,
  ) {
    final espacio = espaciosRepository.obtenerPorId(dto.espacioId);
    final usuario = usuariosRepository.obtenerPorId(dto.usuarioId);

    // Si falta una relación, la reserva no puede construirse correctamente.
    if (espacio == null) {
      throw StateError('No existe el espacio ${dto.espacioId} de la reserva ${dto.id}.');
    }
    if (usuario == null) {
      throw StateError('No existe el usuario ${dto.usuarioId} de la reserva ${dto.id}.');
    }

    // Comprobamos los asistentes y que la actividad sea válida para el espacio.
    if (dto.asistentes <= 0 || dto.asistentes > espacio.aforo) {
      throw FormatException('El número de asistentes de la reserva ${dto.id} no es válido.');
    }
    if (!espacio.admiteActividad(dto.actividad)) {
      throw FormatException('La actividad de la reserva ${dto.id} no está admitida por el espacio.');
    }

    // El precio se comprueba usando la duración y los extras guardados.
    final inicio = DateTime.parse(dto.inicioIso);
    final fin = DateTime.parse(dto.finIso);
    final minutos = fin.difference(inicio).inMinutes;
    if (minutos <= 0 || minutos % 60 != 0) {
      throw StateError('El intervalo de la reserva ${dto.id} no es válido.');
    }

    final extras = dto.serviciosContratados.map((extra) {
      return ServicioContratado(
        servicioId: extra.servicioId,
        nombre: extra.nombre,
        precioCentimos: extra.precioCentimos,
      );
    }).toList();

    final totalExtras = extras.fold<int>(
      0,
      (total, extra) => total + extra.precioCentimos,
    );
    final totalEsperado = dto.tarifaHoraCentimos * (minutos ~/ 60) + totalExtras;
    if (dto.precioTotalCentimos != totalEsperado) {
      throw StateError('El precio de la reserva ${dto.id} no coincide con su desglose.');
    }

    return dominio.Reserva(
      id: dto.id,
      espacio: espacio,
      usuario: usuario,
      actividad: dto.actividad,
      inicio: inicio,
      fin: fin,
      asistentes: dto.asistentes,
      estado: _convertirEstado(dto.codigoEstado),
      serviciosContratados: List.unmodifiable(extras),
      tarifaHoraCentimos: dto.tarifaHoraCentimos,
      precioTotalCentimos: dto.precioTotalCentimos,
      moneda: dto.moneda,
    );
  }

  /// Traduce el código que llega en el DTO al enum del dominio.
  static dominio.EstadoReserva _convertirEstado(String codigo) {
    switch (codigo) {
      case 'CONF':
        return dominio.EstadoReserva.confirmada;
      case 'PEND':
        return dominio.EstadoReserva.pendiente;
      case 'CANC':
        return dominio.EstadoReserva.cancelada;
      default:
        throw FormatException('Estado de reserva desconocido: $codigo');
    }
  }
}
