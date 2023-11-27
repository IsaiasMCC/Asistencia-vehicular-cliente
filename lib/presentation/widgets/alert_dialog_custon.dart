import 'package:flutter/material.dart';

void showAlertCuston(BuildContext context, String text, VoidCallback onPressed) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(text),
        //content: Text(text),
        actions: <Widget>[
          TextButton(
            onPressed: onPressed,
            child: const Text('Aceptar'),
          ),
        ],
      );
    },
  );
}
