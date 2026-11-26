import 'package:flutter/material.dart';

/// Agrupa contenido relacionado bajo un título común.
/// Se utiliza en distintas pantallas para mantener una jerarquía visual uniforme.
class TarjetaSeccion extends StatelessWidget {
  const TarjetaSeccion({
    super.key,
    required this.titulo,
    required this.child,
    this.icono,
  });

  final String titulo;
  final Widget child;
  final IconData? icono;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icono != null) ...[
                Icon(icono, size: 20, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
              ],
              Text(titulo, style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
