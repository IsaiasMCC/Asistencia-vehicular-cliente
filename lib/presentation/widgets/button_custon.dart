import 'package:flutter/material.dart';

class ButtonCuston extends StatelessWidget {
  final String textTitle;
  final VoidCallback onPressed;
  const ButtonCuston({
    super.key,
    required this.textTitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding:
              const EdgeInsets.all(16.0), // Ajusta el espacio interno del botón
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Bordes redondeados
          ),
          elevation: 1.0, // Altura de la sombra
          shadowColor: Colors.blue, // Color de la sombra
        ),
        child: Text(
          textTitle,
          style: const TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
