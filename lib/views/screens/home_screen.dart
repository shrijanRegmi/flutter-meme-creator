import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meme_creator/viewmodels/home_vm.dart';
import 'package:meme_creator/viewmodels/vm_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VMProvider<HomeVm>(
      vm: HomeVm(context),
      builder: (context, vm) {
        return Scaffold(
          body: Column(
            children: const [],
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: '1',
                child: const Icon(
                  Icons.image_rounded,
                ),
                onPressed: () => vm.pickImage(
                  source: ImageSource.gallery,
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              FloatingActionButton(
                heroTag: '2',
                child: const Icon(
                  Icons.camera_alt_rounded,
                ),
                onPressed: () => vm.pickImage(
                  source: ImageSource.camera,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
