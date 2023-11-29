import 'package:asistencia_vehicular_cliente/presentation/blocs/loca_storage_bloc/local_storage_bloc.dart';
import 'package:asistencia_vehicular_cliente/presentation/widgets/alert_dialog_custon.dart';
import 'package:asistencia_vehicular_cliente/presentation/widgets/button_custon.dart';
import 'package:asistencia_vehicular_cliente/presentation/widgets/input_text_custon.dart';
import 'package:asistencia_vehicular_cliente/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final localStorageBloc = context.watch<LocalStorageBloc>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0XFF3C3E52),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 80.0,
              ),
              const Center(
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 48.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 30.0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/car-repair.png',
                      width: 120.0,
                    ),
                    const Text(
                      "Car Repair",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      width: 150,
                      child: const Text(
                        "Authenticate using your email and password",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, height: 1.5),
                      ),
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: TextFormField(
                                  controller: _correoController,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                      iconColor: Colors.white,
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                      icon: Icon(Icons.mail),
                                      labelText: "Email"),
                                  keyboardType: TextInputType.emailAddress,
                                  obscureText: false,
                                  readOnly: false,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return "Escriba su correo por favor";
                                    }
                                    return null;
                                  }),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: TextFormField(
                                  controller: _contrasenaController,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                      iconColor: Colors.white,
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                      icon: Icon(Icons.password),
                                      labelText: "Password"),
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  readOnly: false,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return "Escriba su password por favor";
                                    }
                                    return null;
                                  }),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ButtonCuston(
                                textTitle: 'Iniciar Sesión',
                                onPressed: () =>
                                    onSubmitLogin(localStorageBloc)),
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
                            ),
                          ],
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onSubmitLogin(LocalStorageBloc localStorageBloc) {
    if (_correoController.text.isNotEmpty &&
        _contrasenaController.text.isNotEmpty) {
      authService
          .login(_correoController.text, _contrasenaController.text)
          .then((res) {
        if (res['success'] ?? false) {
          localStorageBloc.setUser(res['data']);
          if (res['data']['roles'][0]['rol_id'] == 2) {
            context.replaceNamed('/home_cliente');
          } else {
            context.replaceNamed('/homeTaller');
          }
          return;
        }
        showAlertCuston(context, 'Error al autenticarse', () {
          context.pop();
        });
        return;
      }).catchError((err) {
        print(err);
      });
    }
  }
}
