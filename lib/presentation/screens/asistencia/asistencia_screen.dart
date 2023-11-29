import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AsistenciaScreen extends StatelessWidget {
  const AsistenciaScreen({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitudes'),
      ),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                context.pushNamed('/nuevaAsistencia');
              },
              icon: const Icon(Icons.add),
              label: const Text('Nueva Solicitud'),
            ),
             ElevatedButton.icon(
              onPressed: () {
                context.pushNamed('/postulaciones');
              },
              icon: const Icon(Icons.remove_red_eye_outlined),
              label: const Text('Ver Postulaciones a mi Solicitud'),
            ),
             ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.history),
              label: const Text('Historial de Solicitudes'),
            ),
            
          ]
        )
      ),
    );
  }
}