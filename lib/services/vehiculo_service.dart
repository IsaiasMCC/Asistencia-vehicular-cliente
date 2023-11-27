import 'dart:convert';
import 'package:asistencia_vehicular_cliente/domain/helper/register_vehiculo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VehiculoService extends ChangeNotifier {
  final baseUrl = '149.50.133.183';

  Future<dynamic?> registerVehiculo(RegisterVehiculo data) async {
    try {
      final url = Uri.http(baseUrl, '/public/api/register-vehiculo');
      var request = http.MultipartRequest(
        'POST',
        url,
      );
      
      // Agrega datos al formulario
      request.fields['placa'] = data.placa;
      request.fields['marca'] = data.marca;
      request.fields['modelo'] = data.modelo;
      request.fields['color'] = data.color;
      request.fields['tipo'] = data.tipo;
      request.fields['user_id'] = data.user_id.toString();

      // Agrega la imagen como archivo
      request.files.add(
        await http.MultipartFile.fromPath(
          'foto',
          data.image,
        ),
      );
      var resp = await request.send();
      final decodedResp = json.decode(await resp.stream.bytesToString());
      if (resp.statusCode == 200) {
        print(decodedResp);
        return decodedResp;
      }
      return decodedResp;
    } catch (e) {
      print('Error: $e');
      return {'status': 500, 'message': 'Internal server error'};
    }
  }

  Future<List<dynamic?>> getAllVehiculesbyClient(String clientId) async {
    try {
      final url = Uri.http(baseUrl, '/public/api/get-my-vehiculos/$clientId');
      final resp = await http.get(
        url,
        headers: {'Accept': 'application/json'},
      );
      final Map<String, dynamic> decodedResp = json.decode(resp.body);
      if (resp.statusCode == 200) {
        return decodedResp['data'];
      }
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }
}
