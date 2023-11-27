import 'package:asistencia_vehicular_cliente/presentation/widgets/button_custon.dart';
import 'package:asistencia_vehicular_cliente/presentation/widgets/input_text_custon.dart';
import 'package:asistencia_vehicular_cliente/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _correoController = TextEditingController();
  final _contrasenaController = TextEditingController();
  final authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar Sesión'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              ButtonCuston(
                  textTitle: 'Iniciar Sesión', onPressed: onSubmitLogin),
              const SizedBox(height: 5),
              Center(
                child: TextButton(
                  onPressed: () {
                    context.replaceNamed('/register');
                  },
                  child: const Text(
                    'registrarse',
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

  void onSubmitLogin() {
    if (_correoController.text.isNotEmpty &&
        _contrasenaController.text.isNotEmpty) {
      authService
          .login(_correoController.text, _contrasenaController.text)
          .then((res) => {print(res)})
          .catchError((err) {
        print(err);
      });
    }
  }
}
