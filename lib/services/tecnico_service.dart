import 'dart:convert';
import 'package:asistencia_vehicular_cliente/domain/interfaces/task_interface.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class TecnicoService extends ChangeNotifier {
  final baseUrl = '149.50.133.183';

  Future<ResponsePostulacion> getPostulacion() async {
    String tecnicoId = '1';
    final url = Uri.http(
      baseUrl,
      '/public/api/tarea/$tecnicoId',
    );
    final resp = await http.get(url);
    ResponsePostulacion respuestaPostulacion =
        responsePostulacionFromJson(resp.body);
    return respuestaPostulacion;
  }

  Future<bool?> terminarSolicitud(tecnicoId, solicitudId, postulacionId) async {
    try {
      final url = Uri.http(baseUrl, '/public/api/terminar-solicitud');
      final body = {
        'solicitud_id': solicitudId,
        'tecnico_id': tecnicoId,
        'postulacion_id': postulacionId,
      };

      final resp = await http.post(
        url,
        headers: {'Accept': 'application/json'},
        body: body,
      );
      final Map<String, dynamic> decodedResp = json.decode(resp.body);
      if (resp.statusCode == 200) {
        if (decodedResp['success']) {
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<bool> actualizarMiPosicion()async{
    //TODO: obtener el id del usaurio del local sharede preferece
    String user_id = '1';
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Servicio de ubicación desactivado");
    }
    Position position = await Geolocator.getCurrentPosition();
    try {
      final url = Uri.http(baseUrl, '/public/api/actualizar-posicion');
      final body = {
        'id': user_id,
        'latitud': position.latitude,
        'longitud': position.longitude,
      };

      final resp = await http.post(
        url,
        headers: {'Accept': 'application/json'},
        body: body,
      );
      if (resp.statusCode == 200) {
      // final Map<String, dynamic> decodedResp = json.decode(resp.body);
        return true;
      }else{
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
