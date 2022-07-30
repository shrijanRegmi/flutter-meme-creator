import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meme_creator/utils/app_routes.dart';
import 'package:meme_creator/viewmodels/base_vm.dart';
import 'package:meme_creator/views/screens/photo_editor_screen.dart';

class HomeVm extends BaseVm {
  final BuildContext context;
  HomeVm(this.context);

  XFile? _file;
  XFile? get file => _file;

  // pick image
  void pickImage({
    required final ImageSource source,
  }) async {
    final _imagePicker = ImagePicker();
    final _pickedImg = await _imagePicker.pickImage(
      source: source,
    );

    if (_pickedImg != null) {
      _file = _pickedImg;
      notifyListeners();

      Navigator.pushNamed(
        context,
        AppRoutes.photoEditorScreen,
        arguments: PhotoEditorScreenArgs(
          imgFile: _file!,
        ),
      );
    }
  }
}
