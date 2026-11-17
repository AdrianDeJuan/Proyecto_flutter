import 'package:flutter/material.dart';

class Anadirimagen extends StatelessWidget {
  final String rutaImagen;
  final double altura;
  final double anchura;
  const Anadirimagen({
    super.key,
    required this.rutaImagen,
    required this.altura,
    required this.anchura,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        rutaImagen,
        height: altura,
        width: anchura,
        fit: BoxFit.cover,
      ),
    );
  }
}
