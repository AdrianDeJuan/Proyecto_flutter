import 'package:flutter/material.dart';

class BotonConIcono extends StatelessWidget {
  final Icon icono;
  final String mensajeDeAyuda;
  final Widget claseALaQueIr;

  const BotonConIcono({
    super.key,
    required this.icono,
    required this.mensajeDeAyuda,
    required this.claseALaQueIr,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icono,
      tooltip: mensajeDeAyuda,
      onPressed: () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute<void>(builder: (context) => claseALaQueIr),
          (route) => false,
        );
      },
    );
  }
}
