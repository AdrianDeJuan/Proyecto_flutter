import 'package:flutter/material.dart';

/// Imagen decorativa que podemos reutilizar como fondo.
class ImagenDecorativa extends StatelessWidget {
  const ImagenDecorativa({
    super.key,
    required this.rutaImagen,
    this.ancho = 150,
    this.opacidad = 0.18,
  });

  // Ruta de la imagen que queremos mostrar.
  final String rutaImagen;

  // Anchura de la imagen.
  final double ancho;

  // Transparencia de la imagen.
  final double opacidad;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ExcludeSemantics(
        child: Opacity(
          opacity: opacidad,
          child: Image.asset(rutaImagen, width: ancho, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
