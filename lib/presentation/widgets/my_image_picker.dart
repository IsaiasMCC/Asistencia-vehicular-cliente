
import 'dart:io';
import 'package:flutter/material.dart';


class MyImagePicker extends StatelessWidget {
  final VoidCallback onLoadImage;
  // Variable para almacenar la imagen seleccionada
  File? selectedImageFile;

  MyImagePicker({
    super.key,
    required this.onLoadImage,
    required this.selectedImageFile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Mostrar la imagen seleccionada
        if (selectedImageFile != null)
          Image.file(
            selectedImageFile!, // Utiliza el objeto File
            height: 200.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

        // Botón para cargar imagen desde la galería
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton.icon(
            onPressed: onLoadImage,
            icon: const Icon(Icons.image),
            label: const Text('Cargar imagen de su Auto'),
          ),
        ),
      ],
    );
  }
}