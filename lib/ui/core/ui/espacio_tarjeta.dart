import 'package:flutter/material.dart';
import '../../../domain/models/espacio.dart';
import '../../../utils/formato_utils.dart';

/// Tarjeta reutilizable para representar un espacio en el catálogo o en listas.
class TarjetaEspacio extends StatelessWidget {
  const TarjetaEspacio({
    super.key,
    required this.espacio,
    required this.onTap,
  });

  final Espacio espacio;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // La imagen ocupa una altura fija para que las tarjetas queden alineadas.
            SizedBox(
              height: 165,
              width: double.infinity,
              child: Image.asset(
                espacio.imagenAsset,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const _ImagenEspacioVacia(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          espacio.nombre,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      if (espacio.destacado)
                        const Icon(Icons.star, color: Colors.amber, size: 19),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 16),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          espacio.ubicacion,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${espacio.aforo} personas'),
                      Text(
                        '${formatearPrecio(espacio.precioHoraCentimos, espacio.moneda)}/h',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Placeholder visual para cuando una imagen todavía no está disponible.
class _ImagenEspacioVacia extends StatelessWidget {
  const _ImagenEspacioVacia();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey.shade50,
      alignment: Alignment.center,
      child: Icon(
        Icons.image_not_supported_outlined,
        size: 44,
        color: Colors.blueGrey.shade300,
      ),
    );
  }
}
