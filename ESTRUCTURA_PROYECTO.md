# Estructura del proyecto

Se conserva la organización funcional original del alumno:

```text
lib/
├── main.dart
├── app_dependencies.dart
├── app_theme.dart
├── data/
│   ├── models/
│   ├── repositories/
│   └── services/
├── domain/
│   └── models/
├── ui/
│   ├── acceso/
│   │   ├── ui/
│   │   ├── widgets/
│   │   └── view_models/
│   ├── core/
│   │   └── ui/
│   ├── espacios/
│   │   ├── ui/
│   │   └── view_models/
│   ├── perfil/
│   │   ├── ui/
│   │   └── view_models/
│   └── reservas/
│       ├── ui/
│       └── view_models/
└── utils/
```

`data/`, `domain/`, `ui/` y `utils/` se mantienen como carpetas principales. Las pantallas continúan agrupadas por funcionalidad y los componentes compartidos permanecen en `ui/core/ui/`.

Se han añadido subcarpetas `view_models/` donde las vistas con datos necesitan ViewModels, siguiendo la indicación docente. Los nombres `Widgets` y `viewmodels` del ZIP original se normalizan a `widgets` y `view_models` para seguir la convención de nombres del proyecto.

No se crea una carpeta `app/`: la composición de dependencias y el tema se mantienen en archivos en la raíz de `lib/`. La navegación utiliza `Navigator`; GoRouter queda aplazado.
