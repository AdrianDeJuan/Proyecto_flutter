import 'data/repositories/comentarios_repository.dart';
import 'data/repositories/disponibilidad_repository.dart';
import 'data/repositories/espacios_repository.dart';
import 'data/repositories/reservas_repository.dart';
import 'data/repositories/usuarios_repository.dart';
import 'data/services/datos_demo.dart';
import 'data/services/datos_simulados_service.dart';
import 'ui/espacios/view_models/espacios_view_model.dart';
import 'ui/perfil/view_models/perfil_view_model.dart';
import 'ui/reservas/view_models/mis_reservas_view_model.dart';

/// Construye las dependencias de la aplicación en un único punto.
/// Así evitamos crear servicios y repositorios dentro de las pantallas.
class AppDependencies {
  AppDependencies() {
    // El servicio utiliza las listas DTO definidas en datos_demo.dart.
    final service = DatosSimuladosService(
      espacios: espaciosDemo,
      reservas: reservasDemo,
      usuarios: usuariosDemo,
      comentarios: comentariosDemo,
      disponibilidad: disponibilidadDemo,
    );

    // Creamos primero los repositorios que no dependen de otros repositorios.
    espaciosRepository = EspaciosRepository(service: service);
    usuariosRepository = UsuariosRepository(service: service);

    // Después creamos los repositorios que necesitan resolver relaciones.
    reservasRepository = ReservasRepository(
      service: service,
      espaciosRepository: espaciosRepository,
      usuariosRepository: usuariosRepository,
    );
    comentariosRepository = ComentariosRepository(
      service: service,
      espaciosRepository: espaciosRepository,
      usuariosRepository: usuariosRepository,
    );
    disponibilidadRepository = DisponibilidadRepository(
      service: service,
      espaciosRepository: espaciosRepository,
    );

    // Creamos los ViewModels compartidos por las pantallas principales.
    espaciosViewModel = EspaciosViewModel(
      repository: espaciosRepository,
    );
    perfilViewModel = PerfilViewModel(
      repository: usuariosRepository,
    );
    misReservasViewModel = MisReservasViewModel(
      repository: reservasRepository,
      usuarioId: 'u1',
    );
  }

  late final EspaciosRepository espaciosRepository;
  late final UsuariosRepository usuariosRepository;
  late final ReservasRepository reservasRepository;
  late final ComentariosRepository comentariosRepository;
  late final DisponibilidadRepository disponibilidadRepository;

  late final EspaciosViewModel espaciosViewModel;
  late final PerfilViewModel perfilViewModel;
  late final MisReservasViewModel misReservasViewModel;
}
