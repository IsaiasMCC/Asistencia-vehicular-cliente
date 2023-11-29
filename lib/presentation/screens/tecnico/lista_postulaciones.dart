import 'package:asistencia_vehicular_cliente/domain/interfaces/postulaciones.dart';
import 'package:asistencia_vehicular_cliente/services/tecnico_service.dart';
import 'package:flutter/material.dart';

class ListPostulaciones extends StatelessWidget {
  ListPostulaciones({super.key});
  TecnicoService tecnicoService = new TecnicoService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Lista de Postulaciones'),
          leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "home");
              },
              icon: const Icon(Icons.home)),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "reclamo");
                },
                icon: const Icon(Icons.add))
          ]),
      //LISTA O HISTORIA DE RECLAMO
      body: FutureBuilder(
        future: tecnicoService.getPostulaciones(),
        builder: (BuildContext context,
            AsyncSnapshot<ResponseAllPostulacion> snapshot) {
          if (snapshot.hasData) {
            List<Postulacione>? postulaciones = snapshot.data!.postulaciones;
            if (postulaciones!.length > 0) {
              return ListView.separated(
                itemCount: postulaciones.length,
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 5,
                    thickness: 0.5,
                  );
                },
                itemBuilder: (context, index) {
                  if (postulaciones.isNotEmpty) {
                    return Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        //set border radius more than 50% of height and width to make circle
                      ),
                      child: ListTile(
                        title: Text(postulaciones[index].taller!.nombre!),
                        subtitle: Text(
                            'Costo Estimado: ${postulaciones[index].estimacionCosto}\n Tiempo Estimado: ${postulaciones[index].estimacionLlegada}'),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                        onTap: (() {}),
                        //TODO: SE PUEDE COLOCAR IMAGEN CON leading
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            } else {
              return const Center(
                child: Text('No hay registros'),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
