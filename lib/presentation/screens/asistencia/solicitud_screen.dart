import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:audioplayers/audioplayers.dart';

class SolicitudScreen extends StatefulWidget {
  const SolicitudScreen({super.key});

  @override
  State<SolicitudScreen> createState() => _SolicitudScreenState();
}

class _SolicitudScreenState extends State<SolicitudScreen> {
  File? _image;
  late AudioPlayer _audioPlayer;
   @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }
    Future<void> _captureImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
   Future<void> _captureAudio() async {
    // Implementar la lógica para capturar audio aquí
  }
    @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Capturar Imagen y Audio'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('No se ha capturado ninguna imagen.')
                : Image.file(_image!),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _captureImage,
              child: Text('Capturar Imagen'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _captureAudio,
              child: Text('Capturar Audio'),
            ),
             SizedBox(height: 20),
            ElevatedButton(
              onPressed: _captureAudio,
              child: Text('Guardar Solicitud'),
            ),
          ],
        ),
      ),
    );
  }
}
