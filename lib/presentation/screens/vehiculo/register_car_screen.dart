import 'dart:io';
import 'package:asistencia_vehicular_cliente/domain/helper/register_vehiculo.dart';
import 'package:asistencia_vehicular_cliente/presentation/blocs/loca_storage_bloc/local_storage_bloc.dart';
import 'package:asistencia_vehicular_cliente/services/vehiculo_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import 'package:asistencia_vehicular_cliente/presentation/widgets/input_text_form_custon.dart';
import 'package:asistencia_vehicular_cliente/presentation/widgets/my_image_picker.dart';
import 'package:asistencia_vehicular_cliente/presentation/widgets/button_custon.dart';
import 'package:asistencia_vehicular_cliente/presentation/widgets/alert_dialog_custon.dart';

class RegisterCarScreen extends StatefulWidget {
  const RegisterCarScreen({super.key});

  @override
  State<RegisterCarScreen> createState() => _RegisterCarScreenState();
}

class _RegisterCarScreenState extends State<RegisterCarScreen> {
  late TextEditingController _placaController;
  late TextEditingController _marcaController;
  late TextEditingController _modeloController;
  late TextEditingController _colorController;
  late TextEditingController _tipoController;
  late TextEditingController _imageController;
  File? selectedImageFile;

  @override
  void initState() {
    super.initState();
    _placaController = TextEditingController();
    _marcaController = TextEditingController();
    _modeloController = TextEditingController();
    _colorController = TextEditingController();
    _tipoController = TextEditingController();
    _imageController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final vehiculoService = VehiculoService();
    final localStorageBloc = context.watch<LocalStorageBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Vehiculo'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 20, vertical: 15),
          child: Column(
            children: [
              InputTextFormCuston(
                label: 'Placa',
                icon: Icons.numbers,
                textController: _placaController,
              ),
              const SizedBox(height: 10),
              InputTextFormCuston(
                label: 'Marca',
                icon: Icons.car_repair_rounded,
                textController: _marcaController,
              ),
              const SizedBox(height: 10),
              InputTextFormCuston(
                label: 'Modelo',
                icon: Icons.date_range_outlined,
                textController: _modeloController,
              ),
              const SizedBox(height: 10),
              InputTextFormCuston(
                label: 'Color',
                icon: Icons.color_lens_outlined,
                textController: _colorController,
              ),
              const SizedBox(height: 10),
              InputTextFormCuston(
                label: 'Tipo',
                icon: Icons.type_specimen,
                textController: _tipoController,
              ),
              const SizedBox(height: 10),
              MyImagePicker(
                onLoadImage: () => cargarImagen(_imageController),
                selectedImageFile: selectedImageFile,
              ),
              ButtonCuston(
                  textTitle: 'Registrar Vehiculo',
                  onPressed: () {
                    if (_placaController.text.isNotEmpty &&
                        _marcaController.text.isNotEmpty &&
                        _modeloController.text.isNotEmpty &&
                        _colorController.text.isNotEmpty &&
                        _tipoController.text.isNotEmpty) {
                      dynamic userr = localStorageBloc.state.user;
                      //userr = userr['roles'][0]['rol_id'];
                      final data = RegisterVehiculo(
                        placa: _placaController.text,
                        marca: _marcaController.text,
                        modelo: _modeloController.text,
                        color: _colorController.text,
                        tipo: _tipoController.text,
                        image: _imageController.text,
                        user_id: userr['id'],
                      );
                      vehiculoService.registerVehiculo(data).then((res) => {
                            showAlertCuston(
                              context,
                              'Vehiculo registrado Correctamente',
                              () {
                                context.pushReplacement('/car/list');
                              },
                            )
                          });
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  Future<void> cargarImagen(TextEditingController controller) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImageFile = pickedImage != null ? File(pickedImage.path) : null;
      controller.text = pickedImage!.path;
    });
  }
}
