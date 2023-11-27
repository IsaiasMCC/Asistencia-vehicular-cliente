import 'package:asistencia_vehicular_cliente/config/router/app_router.dart';
import 'package:asistencia_vehicular_cliente/presentation/blocs/loca_storage_bloc/local_storage_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        lazy: false,
        create: (_) => LocalStorageBloc(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Asistencia Vehicular',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
    );
  }
}
