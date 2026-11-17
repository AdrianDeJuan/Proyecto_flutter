import 'package:flutter/material.dart';

class Placeholder extends StatelessWidget {
  final double altura;
  final double anchura;
  const Placeholder({super.key, required this.altura, required this.anchura});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: altura,
        width: anchura,
        //Borde redonde fondo gris
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),

        //Column para poder poner verticalmente la imagen y texto del placeholder
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .center, //Esto centra el contenido a la altura del contenedor
          children: const [
            Icon(Icons.image_outlined, size: 50, color: Colors.grey),
            SizedBox(height: 8),
            Text(
              'Placeholder de Imagen',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
