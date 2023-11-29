import 'package:asistencia_vehicular_cliente/presentation/blocs/loca_storage_bloc/local_storage_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TecnicoHome extends StatelessWidget {
  const TecnicoHome({super.key});

  @override
  Widget build(BuildContext context) {
    final localStorageBloc = context.watch<LocalStorageBloc>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  bool ok = await localStorageBloc.dropUser();
                  if (ok) {
                    Future.microtask(() {
                      context.pushReplacement('/login');
                    });
                  }
                })
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  context.pushNamed('/task');
                },
                icon: const Icon(Icons.history),
                label: const Text('Ver Postulaciones'),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text('Cambiar disponibilidad'),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.remove_red_eye_outlined),
                label: const Text('Actualizar posicion'),
              ),
            ],
          ),
        ));
  }
}
