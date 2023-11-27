import 'package:asistencia_vehicular_cliente/controller/map_controller.dart';
import 'package:asistencia_vehicular_cliente/domain/interfaces/task_interface.dart';
import 'package:asistencia_vehicular_cliente/services/tecnico_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart'; // for date format
import 'package:intl/date_symbol_data_local.dart'; // for other locales

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TecnicoService tecnicoService = TecnicoService();
    return ChangeNotifierProvider<MapController>(
        create: (_) => MapController(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Pendiente a Realizar'),
            actions: [
              IconButton(
                onPressed: () {
                  print('actualizar posicion');
                },
                icon: const Icon(Icons.refresh),
              )
            ]
          ),
          body: FutureBuilder(
              future: tecnicoService.getPostulacion(),
              builder: (BuildContext context,
                  AsyncSnapshot<ResponsePostulacion> snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data!;
                  final postulacion = data.data!;
                  initializeDateFormatting('es');
                  final fecha = DateFormat.yMd('es')
                      .format(postulacion.solicitud!.fecha!);
                  return Column(
                    children: [
                      Text("Fecha: ${fecha}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Text("Hora: ${postulacion.solicitud!.hora!}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Text("Estado: ${postulacion.solicitud!.estado!}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Divider(
                        color: Colors.grey.shade400,
                        thickness: 1,
                      ),
                      Container(
                        width: 500,
                        height: 500,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 20),
                        child: Consumer<MapController>(
                            builder: (_, controller, __) => MiMapa(
                                controller: controller,
                                latitud: postulacion.solicitud!.latitud!,
                                longitud: postulacion.solicitud!.longitud!)),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          bool? resp = await tecnicoService.terminarSolicitud(postulacion.tecnicoId, postulacion.solicitudId, postulacion.id);
                          if(resp == true){
                            
                          }else{
                            print("error no se pudo terminar la solicitud");
                          }
                        },
                        child: const Text(
                          'Finalizar',
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ));
  }
}

class MiMapa extends StatelessWidget {
  final String latitud;
  final String longitud;
  final MapController controller;
  const MiMapa(
      {super.key,
      required this.controller,
      required this.latitud,
      required this.longitud});

  @override
  Widget build(BuildContext context) {
    controller.ubicacion(LatLng(double.parse(latitud), double.parse(longitud)));
    return GoogleMap(
      onMapCreated: controller.onMapCretted,
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      mapType: MapType.normal,
      initialCameraPosition: controller.initialCamarePosition,
      // onTap: controller.onTap,
      markers: controller.markers,
      circles: controller.circles,
    );
  }
}
