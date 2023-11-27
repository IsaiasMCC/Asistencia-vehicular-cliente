import 'dart:convert';

import 'package:asistencia_vehicular_cliente/domain/helper/register_data.dart';
import 'package:asistencia_vehicular_cliente/presentation/widgets/button_custon.dart';
import 'package:asistencia_vehicular_cliente/presentation/widgets/input_text_custon.dart';
import 'package:asistencia_vehicular_cliente/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _ciController = TextEditingController();
  final _direccionController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _correoController = TextEditingController();
  final _contrasenaController = TextEditingController();

  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Cliente'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputTextCuston(
                  inputController: _nombreController,
                  iconInput: Icons.person,
                  label: 'Nombre',
                  hintText: 'Ingrese su nombre',
                  inputType: TextInputType.text),
              const SizedBox(height: 10),
              InputTextCuston(
                  inputController: _apellidoController,
                  iconInput: Icons.person,
                  label: 'Apellido',
                  hintText: 'Ingrese su apellido',
                  inputType: TextInputType.text),
              const SizedBox(height: 10),
              InputTextCuston(
                  inputController: _ciController,
                  iconInput: Icons.person,
                  label: 'Ci',
                  hintText: 'Ingrese su ci',
                  inputType: TextInputType.number),
              const SizedBox(height: 10),
              InputTextCuston(
                  inputController: _direccionController,
                  iconInput: Icons.person,
                  label: 'Dirección',
                  hintText: 'Ingrese su dirección',
                  inputType: TextInputType.text),
              const SizedBox(height: 10),
              InputTextCuston(
                  inputController: _telefonoController,
                  iconInput: Icons.person,
                  label: 'Telefono',
                  hintText: 'Ingrese su telefono',
                  inputType: TextInputType.number),
              const SizedBox(height: 10),
              InputTextCuston(
                  inputController: _correoController,
                  iconInput: Icons.person,
                  label: 'Correo',
                  hintText: 'Ingrese su correo',
                  inputType: TextInputType.emailAddress),
              const SizedBox(height: 10),
              InputTextCuston(
                  inputController: _contrasenaController,
                  iconInput: Icons.person,
                  label: 'Contraseña',
                  hintText: 'Ingrese su contraseña',
                  inputType: TextInputType.visiblePassword,
                  obscureText: true),
              const SizedBox(height: 10),
              ButtonCuston(textTitle: 'Registrar', onPressed: onSubmitRegister),
              const SizedBox(height: 5),
              Center(
                child: TextButton(
                  onPressed: () {
                    context.replaceNamed('/login');
                  },
                  child: const Text(
                    'iniciar sesión',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onSubmitRegister() {
    if (_nombreController.text.isNotEmpty &&
        _apellidoController.text.isNotEmpty &&
        _telefonoController.text.isNotEmpty &&
        _ciController.text.isNotEmpty &&
        _direccionController.text.isNotEmpty &&
        _correoController.text.isNotEmpty &&
        _contrasenaController.text.isNotEmpty) {
      final data = RegisterData(
          _nombreController.text,
          _apellidoController.text,
          int.parse(_ciController.text),
          _direccionController.text,
          int.parse(_telefonoController.text),
          _correoController.text,
          _contrasenaController.text);
          print("${data.nombre} + ${data.apellido} + ${data.ci} + ${data.direccion} + ${data.telefono} + ${data.email} + ${data.password}");
          authService.register(data);
    }
  }
}
