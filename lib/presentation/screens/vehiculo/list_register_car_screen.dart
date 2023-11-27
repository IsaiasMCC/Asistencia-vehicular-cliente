import 'package:asistencia_vehicular_cliente/presentation/blocs/loca_storage_bloc/local_storage_bloc.dart';
import 'package:asistencia_vehicular_cliente/services/vehiculo_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ListRegisterCarScreen extends StatelessWidget {
  const ListRegisterCarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localStorageBloc = context.watch<LocalStorageBloc>();
       dynamic userr = localStorageBloc.state.user;
                      //userr = userr['roles'][0]['rol_id'];
    final vehiculoService = VehiculoService();
    final data = vehiculoService.getAllVehiculesbyClient(userr['id'].toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehiculos Registrados'),
        actions: [
          IconButton(
              onPressed: () {
                context.pushNamed('/car/register');
              },
              icon: const Icon(
                Icons.add_circle_outline,
                size: 30,
              ))
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            ); // Muestra un indicador de carga mientras se obtienen los datos.
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No se encontraron datos');
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return CardVehiculo(
                    title: '${snapshot.data![index]['marca']}',
                    subtitle: '${snapshot.data![index]['modelo']}');
              },
            );
          }
        },
      ),
    );
  }
}

class CardVehiculo extends StatelessWidget {
  final String title;
  final String subtitle;
  const CardVehiculo({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 5),
      child: Card(
        color: Colors.blue.shade500, // Fondo de la Card
        child: ListTile(
          contentPadding:
              const EdgeInsets.all(10), // Espaciado interno del ListTile
          title: Text(
            'Marca: $title',
            style: const TextStyle(
              color: Colors.white, // Color del texto
              fontWeight: FontWeight.bold, // Negrita
            ),
          ),
          subtitle: Text(
            'Modelo: $subtitle',
            style: const TextStyle(
              color: Colors.white70, // Color del subtexto
            ),
          ),
          leading: const Icon(
            Icons.directions_car, // Icono a la izquierda del ListTile
            color: Colors.white, // Color del icono
          ),
          onTap: () {
            // Acción cuando se toca el ListTile
          },
        ),
      ),
    );
  }
}
