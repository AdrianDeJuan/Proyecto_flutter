import '../models/usuario_dto.dart';
import '../services/datos_simulados_service.dart';
import '../../domain/models/usuario.dart';

/// Consulta los usuarios de la fuente de datos de demostración.
class UsuariosRepository {
  UsuariosRepository({required DatosSimuladosService service}) {
    final usuariosDto = service.leerUsuarios();

    // Comprobamos identificadores únicos y datos básicos de cada usuario.
    final identificadores = <String>{};
    for (final usuario in usuariosDto) {
      if (usuario.id.trim().isEmpty || !identificadores.add(usuario.id)) {
        throw StateError('Hay un identificador de usuario vacío o duplicado.');
      }
      if (usuario.nombre.trim().isEmpty || usuario.correo.trim().isEmpty) {
        throw FormatException('Los datos del usuario ${usuario.id} están incompletos.');
      }
    }

    // Transformamos y guardamos los usuarios de dominio.
    _usuarios = List.unmodifiable(
      usuariosDto.map(_aDominio),
    );
  }

  // Lista privada de usuarios convertidos.
  late final List<Usuario> _usuarios;

  /// Busca un usuario por su identificador.
  Usuario? obtenerPorId(String id) {
    for (final usuario in _usuarios) {
      if (usuario.id == id) return usuario;
    }
    return null;
  }

  /// Devuelve el usuario de demostración que utiliza la aplicación.
  Usuario obtenerUsuarioDemo() {
    final usuario = obtenerPorId('u1');
    if (usuario == null) {
      throw StateError('No se encuentra el usuario de demostración u1.');
    }
    return usuario;
  }

  /// Convierte un UsuarioDto en un Usuario de dominio.
  static Usuario _aDominio(UsuarioDto dto) {
    return Usuario(
      id: dto.id,
      nombre: dto.nombre,
      correo: dto.correo,
    );
  }
}
