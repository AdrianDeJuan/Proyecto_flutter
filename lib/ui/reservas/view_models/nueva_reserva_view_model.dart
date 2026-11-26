import 'package:flutter/foundation.dart';
import '../../../data/repositories/disponibilidad_repository.dart';
import '../../../data/repositories/espacios_repository.dart';
import '../../../data/repositories/reservas_repository.dart';
import '../../../data/repositories/usuarios_repository.dart';
import '../../../domain/models/disponibilidad_dia.dart';
import '../../../domain/models/espacio.dart';
import '../../../domain/models/franja_disponibilidad.dart';
import '../../../domain/models/reserva.dart';
import '../../../domain/models/servicio_extra.dart';
import '../../../domain/models/servicio_contratado.dart';
import '../../../domain/models/usuario.dart';
import '../../../utils/formato_utils.dart';

/// Gestiona las selecciones y los cálculos del formulario de reserva.
class NuevaReservaViewModel extends ChangeNotifier {
  NuevaReservaViewModel({
    required String espacioId,
    required EspaciosRepository espaciosRepository,
    required UsuariosRepository usuariosRepository,
    required ReservasRepository reservasRepository,
    required DisponibilidadRepository disponibilidadRepository,
  })  : espacio = espaciosRepository.obtenerPorId(espacioId),
        _usuario = usuariosRepository.obtenerUsuarioDemo(),
        _reservasRepository = reservasRepository,
        _disponibilidadRepository = disponibilidadRepository {
    // Si el identificador no corresponde a un espacio, no hay formulario que preparar.
    final espacioActual = espacio;
    if (espacioActual == null) return;

    // Seleccionamos la primera actividad admitida, si existe.
    if (espacioActual.actividades.isNotEmpty) {
      _actividad = espacioActual.actividades.first;
    }

    // Seleccionamos el primer día que tenga alguna franja libre.
    for (final dia in _diasDisponibles) {
      final franjasLibres = dia.franjas.where((franja) => franja.disponible);
      if (franjasLibres.isNotEmpty) {
        _fecha = normalizarFecha(dia.fecha);
        _franja = franjasLibres.first;
        break;
      }
    }
  }

  // El ViewModel obtiene el espacio desde el repositorio y lo expone a la vista.
  final Espacio? espacio;
  final Usuario _usuario;
  final ReservasRepository _reservasRepository;
  final DisponibilidadRepository _disponibilidadRepository;

  String? _actividad;
  DateTime? _fecha;
  FranjaDisponibilidad? _franja;
  int _asistentes = 1;
  final Set<String> _serviciosSeleccionados = {};

  String? get actividad => _actividad;
  DateTime? get fecha => _fecha;
  FranjaDisponibilidad? get franja => _franja;
  int get asistentes => _asistentes;

  /// Devuelve los servicios elegidos sin exponer el Set interno.
  List<ServicioExtra> get serviciosSeleccionados {
    final espacioActual = espacio;
    if (espacioActual == null) return const [];

    return List.unmodifiable(
      espacioActual.serviciosDisponibles.where(
        (servicio) => _serviciosSeleccionados.contains(servicio.id),
      ),
    );
  }

  // Consultamos al repositorio los siete días del espacio seleccionado.
  List<DisponibilidadDia> get _diasDisponibles {
    final espacioActual = espacio;
    if (espacioActual == null) return const [];
    return _disponibilidadRepository.obtenerSieteDias(espacioActual.id);
  }

  List<DisponibilidadDia> get diasDisponibles => _diasDisponibles;

  /// Franjas del día seleccionado.
  List<FranjaDisponibilidad> get franjasDelDia {
    final espacioActual = espacio;
    final fechaActual = _fecha;
    if (espacioActual == null || fechaActual == null) return const [];

    final dia = _disponibilidadRepository.obtenerPorFecha(
      espacioActual.id,
      fechaActual,
    );
    return dia?.franjas ?? const [];
  }

  /// Calcula las horas de la franja seleccionada.
  int get horasReserva {
    final intervalo = _franja;
    if (intervalo == null) return 0;
    return intervalo.fin.difference(intervalo.inicio).inMinutes ~/ 60;
  }

  /// Precio de las horas reservadas, sin extras.
  int get precioBaseCentimos =>
      (espacio?.precioHoraCentimos ?? 0) * horasReserva;

  /// Suma el precio de los servicios elegidos.
  int get precioServiciosCentimos => serviciosSeleccionados.fold<int>(
        0,
        (total, servicio) => total + servicio.precioCentimos,
      );

  /// Total de la reserva en céntimos.
  int get precioTotalCentimos =>
      precioBaseCentimos + precioServiciosCentimos;

  bool get puedeConfirmar =>
      espacio != null &&
      _actividad != null &&
      _fecha != null &&
      _franja != null &&
      _franja!.disponible &&
      _asistentes > 0 &&
      _asistentes <= espacio!.aforo;

  void cambiarActividad(String? actividad) {
    _actividad = actividad;
    notifyListeners();
  }

  void cambiarFecha(DateTime fecha) {
    _fecha = normalizarFecha(fecha);
    _franja = null;

    // Al cambiar la fecha, elegimos la primera franja libre de ese día.
    for (final franja in franjasDelDia) {
      if (franja.disponible) {
        _franja = franja;
        break;
      }
    }
    notifyListeners();
  }

  void cambiarFranja(FranjaDisponibilidad? franja) {
    _franja = franja;
    notifyListeners();
  }

  void cambiarAsistentes(int asistentes) {
    final aforoMaximo = espacio?.aforo ?? 1;
    if (asistentes < 1) {
      _asistentes = 1;
    } else if (asistentes > aforoMaximo) {
      _asistentes = aforoMaximo;
    } else {
      _asistentes = asistentes;
    }
    notifyListeners();
  }

  void alternarServicio(String servicioId, bool seleccionado) {
    if (seleccionado) {
      _serviciosSeleccionados.add(servicioId);
    } else {
      _serviciosSeleccionados.remove(servicioId);
    }
    notifyListeners();
  }

  /// Crea y conserva la reserva en memoria para mostrar la confirmación.
  Reserva confirmar() {
    final espacioActual = espacio;
    if (!puedeConfirmar || espacioActual == null) {
      throw StateError('La reserva todavía no tiene todos los datos necesarios.');
    }

    final intervalo = _franja!;
    final extras = serviciosSeleccionados.map((servicio) {
      return ServicioContratado(
        servicioId: servicio.id,
        nombre: servicio.nombre,
        precioCentimos: servicio.precioCentimos,
      );
    }).toList();

    final reserva = Reserva(
      id: 'r_${DateTime.now().microsecondsSinceEpoch}',
      espacio: espacioActual,
      usuario: _usuario,
      actividad: _actividad!,
      inicio: intervalo.inicio,
      fin: intervalo.fin,
      asistentes: _asistentes,
      estado: EstadoReserva.pendiente,
      serviciosContratados: List.unmodifiable(extras),
      tarifaHoraCentimos: espacioActual.precioHoraCentimos,
      precioTotalCentimos: precioTotalCentimos,
      moneda: espacioActual.moneda,
    );

    // El repositorio conserva la reserva durante esta ejecución.
    _reservasRepository.agregarReserva(reserva);

    // La franja que acabamos de reservar deja de aparecer como libre.
    _disponibilidadRepository.marcarOcupada(
      espacioActual.id,
      intervalo.inicio,
      intervalo.fin,
    );

    return reserva;
  }
}
