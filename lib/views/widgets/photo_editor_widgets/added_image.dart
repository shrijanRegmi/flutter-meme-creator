import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meme_creator/models/image_info_model.dart';
import 'package:meme_creator/utils/app_colors.dart';

class AddedImage extends StatefulWidget {
  final AddedImageInfo imgInfo;
  const AddedImage({
    Key? key,
    required this.imgInfo,
  }) : super(key: key);

  @override
  State<AddedImage> createState() => _AddedImageState();
}

class _AddedImageState extends State<AddedImage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: kcLightGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        width: widget.imgInfo.width < 50.0 ? 50.0 : widget.imgInfo.width,
        height: widget.imgInfo.height < 50.0 ? 50.0 : widget.imgInfo.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: FileImage(
              File(widget.imgInfo.img.path),
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
