import '../../../data/repositories/usuarios_repository.dart';
import '../../../domain/models/usuario.dart';

/// Proporciona a la pantalla de perfil los datos del usuario de demostración.
///
/// Es de solo lectura porque esta entrega no permite editar los datos del perfil.
class PerfilViewModel {
  PerfilViewModel({required UsuariosRepository repository})
      : _usuario = repository.obtenerUsuarioDemo();

  // Conservamos el usuario obtenido del repositorio.
  final Usuario _usuario;

  /// Devuelve los datos del usuario que muestra el perfil.
  Usuario get usuario => _usuario;
}
