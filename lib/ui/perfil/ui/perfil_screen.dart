import 'package:flutter/material.dart';
import 'package:flutter_proyecto_reservar_espacios/ui/acceso/ui/login_screen.dart';
import 'package:flutter_proyecto_reservar_espacios/ui/espacios/ui/espacios_screen.dart';
import 'package:flutter_proyecto_reservar_espacios/ui/reservas/ui/mis_reservas_screen.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mi perfil")),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Column(
            //De base se podria decir que se pone este
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.blue,
                child: Text(
                  "AG",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Adrian De Juan Galan",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 8),
              Text(
                "adrian...@gmail.com",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 20),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Card(
                        child: ListTile(
                          leading: const Icon(Icons.business),
                          //Seran los espacios que habran puesto los clientes para reservar
                          title: const Text('Espacios disponibles'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (context) => EspaciosScreen(),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 5),
                      Card(
                        child: ListTile(
                          leading: const Icon(Icons.calendar_month),
                          title: const Text('Mis reservas'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (context) => MisReservasScreen(),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 5),

                      ListTile(
                        leading: const Icon(Icons.notifications),
                        title: const Text('Notificaciones'),
                        trailing: const Text(
                          'Activadas',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),

                      const SizedBox(height: 5),

                      ListTile(
                        leading: const Icon(Icons.language),
                        title: const Text('Idioma'),
                        trailing: const Text('Español'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    spacing: 5,
                    children: [
                      Icon(Icons.info),
                      Text(
                        "Acerca de la aplicacion",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text("Reserva espacios", style: TextStyle(fontSize: 15)),
                  SizedBox(height: 5),
                  Text(
                    "Version 1.0.0",
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Aplicación para consultar espacios disponibles, conocer sus características y gestionar reservas.",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Card(
            color: Colors.red,
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title: const Text(
                'Cerrar sesión',
                style: TextStyle(color: Colors.white),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  //Indica que borre lo anterior para que no pueda volver atras
                  (route) => false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
