import 'package:image_picker/image_picker.dart';

class AddedImageInfo {
  double left;
  double top;
  XFile img;
  double width;
  double height;

  AddedImageInfo({
    required this.left,
    required this.top,
    required this.img,
    required this.width,
    required this.height,
  });
}
