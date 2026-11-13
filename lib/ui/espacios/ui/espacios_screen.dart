import 'package:flutter/material.dart';
import 'package:flutter_proyecto_reservar_espacios/domain/models/contacto_local.dart';
import 'package:flutter_proyecto_reservar_espacios/domain/models/espacio.dart';
import 'package:flutter_proyecto_reservar_espacios/ui/core/ui/espacio_tarjeta.dart';
import 'package:flutter_proyecto_reservar_espacios/ui/espacios/ui/espacio_detalle_screen.dart';
import 'package:flutter_proyecto_reservar_espacios/ui/perfil/ui/perfil_screen.dart';
import 'package:flutter_proyecto_reservar_espacios/ui/reservas/ui/mis_reservas_screen.dart';

class EspaciosScreen extends StatelessWidget {
  const EspaciosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final espacios = _obtenerEspaciosEjemplo();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Espacios Disponibles'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            tooltip: 'Mis reservas',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const MisReservasScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            tooltip: 'Perfil',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const PerfilScreen(),
                ),
              );
            },
          ),
        ],
      ),
      // body: ListView.builder(
      //   itemCount:
      //       espacios.length, //Le dices los elementos que va a usar el builder
      //   //Esto es como hacer el fori de java y el context sirve para saber por que elemento va osea para saber cuales estan ya construidos y cuales no
      //   itemBuilder: (context, index) {
      //     final espacio = espacios[index];

      //     return EspacioTarjeta(
      //       espacio: espacio, //Le da la informacion a la clase espacio tarjeta para que lo cree con su informacion
      //       onTap: () {
      //         //Si pulsas esa lista llama a la clase que necesita saber que espacio es para construir la informacion
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => DetalleEspacioScreen(espacio: espacio),
      //           ),
      //         );
      //       },
      //     );
      //   },
      // ),
    );
  }

  List<Espacio> _obtenerEspaciosEjemplo() {
    return [
      Espacio(
        id: '1',
        nombre: 'Sala Polivalente Alfa',
        descripcion:
            'Sala amplia ideal para eventos grupales y talleres creativos.',
        ubicacion: 'Planta Baja, Edificio Central',
        horario: '08:00 - 22:00',
        condicionesUso: 'Uso exclusivo para actividades autorizadas.',
        aforo: 50,
        imagenAsset: 'assets/images/espacio1.jpg',
        imagenesAssets: ['assets/images/espacio1.jpg'],
        sitioWeb: 'https://ejemplo.com/alfa',
        serviciosDisponibles: [],
        actividades: ['Yoga', 'Pilates', 'Talleres'],
        equipamiento: ['Espejos', 'Equipo de sonido', 'Esterillas'],
        precioHoraCentimos: 1500,
        moneda: '€',
        contacto: ContactoLocal(
          id: "1",
          nombre: "Paco",
          telefono: '123456789',
          correo: 'alfa@ejemplo.com',
        ),
        destacado: true,
        etiqueta: EtiquetaEspacio.popular,
      ),
      Espacio(
        id: '2',
        nombre: 'Cancha Deportiva Central',
        descripcion:
            'Pista polideportiva cubierta para fútbol sala y baloncesto.',
        ubicacion: 'Zona Externa Norte',
        horario: '09:00 - 23:00',
        condicionesUso: 'Obligatorio calzado deportivo limpio.',
        aforo: 120,
        imagenAsset: 'assets/images/espacio2.jpg',
        imagenesAssets: [],
        sitioWeb: null,
        serviciosDisponibles: [],
        actividades: ['Fútbol Sala', 'Baloncesto'],
        equipamiento: ['Porterías', 'Canastas ajustables'],
        precioHoraCentimos: 3000, // 30.00 €
        moneda: '€',
        contacto: ContactoLocal(
          id: "2",
          nombre: "Alguien",
          telefono: '123456789',
          correo: 'alfa@ejemplo.com',
        ),
        destacado: false,
        etiqueta: EtiquetaEspacio.nuevo,
      ),
      Espacio(
        id: '3',
        nombre: 'Sala de Juntas Ejecutiva',
        descripcion:
            'Espacio silencioso y formal para reuniones y videoconferencias.',
        ubicacion: 'Planta 2, Ala Oeste',
        horario: '08:00 - 20:00',
        condicionesUso: 'Mantener silencio en zonas comunes.',
        aforo: 12,
        imagenAsset: 'assets/images/espacio3.jpg',
        imagenesAssets: [],
        sitioWeb: null,
        serviciosDisponibles: [],
        actividades: ['Reuniones', 'Videoconferencias'],
        equipamiento: ['Pantalla 4K', 'Micrófonos de techo', 'Mesa ovalada'],
        precioHoraCentimos: 2500,
        moneda: '€',
        contacto: ContactoLocal(
          id: "3",
          nombre: "Marcos",
          telefono: '123456789',
          correo: 'alfa@ejemplo.com',
        ),
        destacado: true,
        etiqueta: EtiquetaEspacio.vip,
      ),
      Espacio(
        id: '4',
        nombre: 'Terraza Panorámica',
        descripcion: 'Área al aire libre perfecta para networking y descanso.',
        ubicacion: 'Ático',
        horario: '10:00 - 21:00',
        condicionesUso: 'Prohibido fumar en todo el recinto.',
        aforo: 40,
        imagenAsset: 'assets/images/espacio4.jpg',
        imagenesAssets: [],
        sitioWeb: null,
        serviciosDisponibles: [],
        actividades: ['Networking', 'Descanso', 'Eventos al aire libre'],
        equipamiento: ['Mesas altas', 'Sombrillas'],
        precioHoraCentimos: 2000,
        moneda: '€',
        contacto: ContactoLocal(
          id: "4",
          nombre: "Paco",
          telefono: '123456789',
          correo: 'alfa@ejemplo.com',
        ),
        destacado: false,
        etiqueta: EtiquetaEspacio.terraza,
      ),
      Espacio(
        id: '5',
        nombre: 'Aula de Estudio Silencioso',
        descripcion: 'Mesas individuales con iluminación independiente.',
        ubicacion: 'Planta 1, Biblioteca',
        horario: '08:00 - 00:00',
        condicionesUso: 'Silencio absoluto obligatorio.',
        aforo: 30,
        imagenAsset: 'assets/images/espacio5.jpg',
        imagenesAssets: [],
        sitioWeb: null,
        serviciosDisponibles: [],
        actividades: ['Estudio', 'Lectura', 'Investigación'],
        equipamiento: ['Lámparas individuales', 'Enchufes'],
        precioHoraCentimos: 500,
        moneda: '€',
        contacto: ContactoLocal(
          id: "5",
          nombre: "Paco",
          telefono: '123456789',
          correo: 'alfa@ejemplo.com',
        ),
        destacado: false,
        etiqueta: EtiquetaEspacio.silencioso,
      ),
      Espacio(
        id: '6',
        nombre: 'Taller de Prácticas Básicas',
        descripcion: 'Espacio polivalente equipado con mobiliario modular.',
        ubicacion: 'Sótano 1',
        horario: '08:00 - 21:00',
        condicionesUso: 'Recoger y ordenar tras su uso.',
        aforo: 25,
        imagenAsset: 'assets/images/espacio6.jpg',
        imagenesAssets: [],
        sitioWeb: null,
        serviciosDisponibles: [],
        actividades: ['Manualidades', 'Formación básica'],
        equipamiento: ['Mesas modulares', 'Sillas apilables'],
        precioHoraCentimos: 1000,
        moneda: '€',
        contacto: ContactoLocal(
          id: "6",
          nombre: "Paco",
          telefono: '123456789',
          correo: 'alfa@ejemplo.com',
        ),
        destacado: false,
        etiqueta: EtiquetaEspacio.basico,
      ),
    ];
  }
}
