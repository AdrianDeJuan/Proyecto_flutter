import 'package:flutter/material.dart';

/// Representa una línea con icono, etiqueta y valor.
class FilaInformacion extends StatelessWidget {
  const FilaInformacion({
    super.key,
    required this.icono,
    required this.etiqueta,
    required this.valor,
  });

  final IconData icono;
  final String etiqueta;
  final String valor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icono, size: 20, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 10),
          SizedBox(
            width: 125,
            child: Text(etiqueta, style: const TextStyle(color: Colors.black54)),
          ),
          Expanded(
            child: Text(
              valor,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
