import 'dart:convert';
import 'package:asistencia_vehicular_cliente/domain/interfaces/task_interface.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SolicitudService extends ChangeNotifier {
  final baseUrl = '149.50.133.183';

  Future<dynamic?> registerSolcitud(dynamic imagen) async {
    try {
      final url = Uri.http(baseUrl, '/public/api/solicitar');
      var request = http.MultipartRequest(
        'POST',
        url,
      );
      //OBTENER POSICION INI
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error("Servicio de ubicación desactivado");
      }
      Position position = await Geolocator.getCurrentPosition();
      //OBTENER POSICION FIN
      //OBTENER USER_ID INI
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final user = prefs.getString('user') ?? '';
      final ususario = json.decode(user);
      final user_id = ususario['data']['id'];
      //OBTENER USER_ID FIN
      //OBTENER AUDIO
      final String audioAssetPath = 'assets/nota/nota_voz.opus';
      final String audioFileName = 'nota_voz.opus';
     /*  final String audioFilePath =
          await copyAssetToFile(audioAssetPath, audioFileName); */

      // OBTENER AUDIO FIN
      // Agrega datos al formulario
      request.fields['longitud'] = position.longitude.toString();
      request.fields['latitud'] = position.latitude.toString();
      request.fields['user_id'] = user_id.toString();
      // Agrega la imagen como archivo
      request.files.add(
        await http.MultipartFile.fromPath(
          'fotos',
          imagen,
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
  
}
