import 'package:flutter/material.dart';

class TecnicoHome extends StatelessWidget {
  const TecnicoHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: Column(
          children: [
            Text("Datos de USUARIO"),
            Text("Disponibilidad"),
            TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.import_export),
                label: const Text('Cambiar Disponibilidad')),
            Text("posicion actual"),
            TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.import_export),
                label: const Text('Actualizar posicion')),
          ],
        ));
  }
}
