import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceModal extends StatelessWidget {
  ImageSourceModal(this.onImageSelected);

  final Function(File) onImageSelected;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return BottomSheet(
          onClosing: () {},
          builder: (_) => Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextButton(
                    child: const Text('Câmera'),
                    onPressed: getFromCamera,
                  ),
                  TextButton(
                    child: const Text('Galeria'),
                    onPressed: getFromGallery,
                  ),
                ],
              ));
    } else {
      return CupertinoActionSheet(
        title: const Text('Selecionar foto para anúncio'),
        message: const Text('Escolha a origem da foto'),
        cancelButton: TextButton(
          child: const Text(
            'Cancelar',
            style: TextStyle(color: Colors.redAccent),
          ),
          onPressed: Navigator.of(context).pop,
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: getFromCamera,
            child: const Text('Câmera'),
          ),
          CupertinoActionSheetAction(
            onPressed: getFromGallery,
            child: const Text('Galeria'),
          ),
        ],
      );
    }
  }

  Future<void> getFromCamera() async {
    final pickerFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickerFile != null) {
      final image = File(pickerFile.path);
      imageSelected(image);
    }
  }

  Future<void> getFromGallery() async {
    final pickerFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickerFile != null) {
      final image = File(pickerFile.path);
      imageSelected(image);
    }
  }

  Future<void> imageSelected(File image) async {
    final croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Editar Imagem',
          toolbarColor: Colors.purple,
          toolbarWidgetColor: Colors.white),
      iosUiSettings: IOSUiSettings(
        title: "Editar Imagem",
        cancelButtonTitle: 'Cancelar',
        doneButtonTitle: 'Concluir',
      ),
    );
    if (croppedFile != null) onImageSelected(croppedFile);
  }
}
