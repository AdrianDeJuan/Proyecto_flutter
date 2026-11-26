# Reserva de espacios — Entrega 1

Primera implementación de la entrega integradora, construida a partir de los modelos y datos del proyecto original.

## Estructura

Se conserva la organización principal del proyecto original:

- `lib/main.dart`: arranque y composición de la aplicación.
- `lib/data/models/`: DTO.
- `lib/data/services/`: servicio y datos de demostración.
- `lib/data/repositories/`: repositorios.
- `lib/domain/models/`: modelos de dominio.
- `lib/ui/acceso/`: login y registro.
- `lib/ui/core/ui/`: componentes visuales compartidos.
- `lib/ui/espacios/`: catálogo y detalle.
- `lib/ui/perfil/`: perfil.
- `lib/ui/reservas/`: nueva reserva, confirmación y mis reservas.
- `lib/utils/`: funciones auxiliares reutilizables.

Se han añadido carpetas `view_models/` dentro de las funcionalidades que necesitan ViewModels, siguiendo la organización indicada en los criterios de corrección. No se crea una carpeta superior `app/`; la composición de dependencias y el tema están en archivos de nivel `lib/`.

Se conserva el nombre original `espacio_detalle_screen.dart` y el componente compartido `espacio_tarjeta.dart`. Se utiliza `Navigator` para la navegación; GoRouter queda aplazado.

## Ejecutar

Desde la raíz del proyecto:

```bash
flutter pub get
flutter run
```

El proyecto requiere Flutter compatible con Dart `^3.13.4`.

## Notas

- Los datos son de demostración y se mantienen en memoria.
- No se ha implementado persistencia ni conexión a una base de datos real.
- Las imágenes de `assets/images/` son recursos locales de demostración.
- La carpeta `test/` no forma parte de esta reconstrucción.
- Esta entrega debe validarse localmente con `flutter analyze` y ejecutando la aplicación; el entorno donde se preparó no dispone del SDK de Flutter.
