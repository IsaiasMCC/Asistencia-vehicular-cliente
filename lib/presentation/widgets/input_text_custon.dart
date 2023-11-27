import 'package:flutter/material.dart';

class InputTextCuston extends StatelessWidget {
  final TextEditingController inputController;
  final IconData iconInput;
  final String label;
  final String hintText;
  final TextInputType inputType; 
  final bool obscureText;
  const InputTextCuston(
      {super.key,
      required this.inputController,
      required this.iconInput,
      required this.label,
      required this.hintText,
      required this.inputType,
      this.obscureText = false
      });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: inputController,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixIcon: Icon(iconInput), // Icono a la izquierda del campo de texto
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      style: const TextStyle(
        fontSize: 18.0,
        color: Colors.black,
      ),
      keyboardType: inputType,
      obscureText: obscureText,
      // Puedes agregar más propiedades según tus necesidades
    );
  }
}
