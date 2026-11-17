import 'package:flutter/material.dart';
import 'package:flutter_proyecto_reservar_espacios/ui/acceso/ui/login_screen.dart';
import 'package:flutter_proyecto_reservar_espacios/ui/core/ui/espacio_tarjeta.dart';
import 'package:flutter_proyecto_reservar_espacios/ui/espacios/ui/espacio_detalle_screen.dart';
import 'package:flutter_proyecto_reservar_espacios/ui/perfil/ui/perfil_screen.dart';
import 'package:flutter_proyecto_reservar_espacios/ui/reservas/ui/mis_reservas_screen.dart';
import 'package:flutter_proyecto_reservar_espacios/utils/boton_con_icono.dart';
import 'package:flutter_proyecto_reservar_espacios/utils/seeder_prueba.dart';

class EspaciosScreen extends StatelessWidget {
  const EspaciosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final espacios = obtenerEspaciosEjemplo();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Espacios Disponibles'),
        //Cuando vayamos a la parte de statefull widgets hacer aqui condicional de si tiene iniciado sesion que le aparezca el logout y perfil si no log in
        actions: [
          BotonConIcono(
            icono: const Icon(Icons.bookmark_border),
            mensajeDeAyuda: 'Mis reservas',
            claseALaQueIr: const MisReservasScreen(),
          ),
          BotonConIcono(
            icono: const Icon(Icons.person_outline),
            mensajeDeAyuda: 'Perfil',
            claseALaQueIr: const PerfilScreen(),
          ),
          BotonConIcono(
            icono: const Icon(Icons.exit_to_app_outlined, color: Colors.red),
            mensajeDeAyuda: 'LogOut',
            claseALaQueIr: const LoginScreen(),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (contexto, constrains) {
          final columnas = constrains.maxWidth < 660 ? 1 : 2;

          return GridView.builder(
            //Le dices los elementos que va a usar el builder
            itemCount: espacios.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columnas,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              mainAxisExtent: 330,
            ),
            //Esto es como hacer el fori de java y el context sirve para saber por que elemento va osea para saber cuales estan ya construidos y cuales no
            itemBuilder: (context, index) {
              final espacioSacado = espacios[index];

              return EspacioTarjeta(
                espacio: espacioSacado, //Le da la informacion a la clase espacio tarjeta para que lo cree con su informacion
                hacerPulsable: () {
                  //Si pulsas esa lista llama a la clase que necesita saber que espacio es para construir la informacion
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetalleEspacioScreen(espacio: espacioSacado),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
