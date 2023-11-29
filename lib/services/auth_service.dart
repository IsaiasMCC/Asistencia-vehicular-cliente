import 'dart:convert';
import 'package:asistencia_vehicular_cliente/domain/helper/register_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final baseUrl = '149.50.133.183';

  Future<dynamic?> login(String email, String password) async {
    try {
      //final hasConnection = await hasInternet();
      //f (!hasConnection) return 'Revise su conexión a internet';
      final url = Uri.http(baseUrl, '/public/api/login');
      final body = {'email': email, 'password': password};
      final resp = await http.post(
        url,
        headers: {'Accept': 'application/json'},
        body: body,
      );
      final Map<String, dynamic> decodedResp = json.decode(resp.body);
      if (resp.statusCode == 200) {
        return decodedResp;
      }
      return {'status': 400, 'message': 'Error de autenticación'};
    } catch (e) {
      return {'status': 500, 'message': 'Error de conexión con servidor'};
    }
  }
  Future<bool?> register(RegisterData data) async {
    try {
      //final hasConnection = await hasInternet();
      //f (!hasConnection) return 'Revise su conexión a internet';
      final url = Uri.http(baseUrl, '/public/api/register-user');
      final body = {
        'nombre': data.nombre,
        'apellido': data.apellido,
        'ci': data.ci.toString(),
        'direccion': data.direccion,
        'telefono': data.telefono.toString(),
        'email': data.email,
        'password': data.password
      };

      final resp = await http.post(
        url,
        headers: {'Accept': 'application/json'},
        body: body,
      );
      final Map<String, dynamic> decodedResp = json.decode(resp.body);
      if (resp.statusCode == 200) {
        print(decodedResp);
        return true;
      }
      return decodedResp['message'] ?? 'Error de conexión';
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
