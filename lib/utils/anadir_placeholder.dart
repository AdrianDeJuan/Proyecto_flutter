import 'package:flutter/material.dart';

class AnadirPlaceholder extends StatelessWidget {
  final double altura;
  final double anchura;
  const AnadirPlaceholder({
    super.key,
    required this.altura,
    required this.anchura,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        "./assets/images/placeholder.jpg",
        height: altura,
        width: anchura,
        fit: BoxFit.cover,
      ),
    );
  }
}
