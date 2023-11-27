import 'dart:convert';
import 'package:asistencia_vehicular_cliente/domain/helper/register_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final baseUrl = '149.50.133.183';

  Future<String?> login(String email, String password) async {
    try {
      //final hasConnection = await hasInternet();
      //f (!hasConnection) return 'Revise su conexión a internet';
      final url = Uri.https(
        baseUrl,
        '/auth/login',
        {
          'email': email,
          'passwd': password,
        },
      );
      final resp = await http.get(url);
      final Map<String, dynamic> decodedResp = json.decode(resp.body);
      if (resp.statusCode == 200) {
        return null;
      }
      return decodedResp['message'] ?? 'Error de conexión';
    } catch (e) {
      return 'Error de conexión con servidor';
    }
  }

  Future<String?> register(RegisterData data) async {
    try {
      //final hasConnection = await hasInternet();
      //f (!hasConnection) return 'Revise su conexión a internet';
      final url = Uri.http(
        baseUrl,
        '/public/auth/register-user',
        {
          'nombre': data.nombre,
          'apellido': data.apellido,
          'ci': data.ci,
          'direccion': data.direccion,
          'telefono': data.telefono,
          'email': data.email,
          'password': data.password
        },
      );
      final resp = await http.post(url);
      final Map<String, dynamic> decodedResp = json.decode(resp.body);
      if (resp.statusCode == 200) {
        print(decodedResp);
      }
      return decodedResp['message'] ?? 'Error de conexión';
    } catch (e) {
      print('Error: $e');
      return '';
    }
  }
}
