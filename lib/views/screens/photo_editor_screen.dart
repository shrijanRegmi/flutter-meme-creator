import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meme_creator/utils/app_colors.dart';
import 'package:meme_creator/views/widgets/common_widgets/meme_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

import '../../models/added_text_info_model.dart';
import '../../models/image_info_model.dart';
import '../widgets/photo_editor_widgets/added_image.dart';
import '../widgets/photo_editor_widgets/added_text.dart';

class PhotoEditorScreenArgs {
  final XFile imgFile;

  PhotoEditorScreenArgs({
    required this.imgFile,
  });
}

class PhotoEditorScreen extends StatefulWidget {
  final XFile imgFile;
  const PhotoEditorScreen({
    Key? key,
    required this.imgFile,
  }) : super(key: key);

  @override
  State<PhotoEditorScreen> createState() => _PhotoEditorScreenState();
}

class _PhotoEditorScreenState extends State<PhotoEditorScreen> {
  XFile? _imgFile;

  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _creatorText = TextEditingController();
  final ScreenshotController _screenshotController = ScreenshotController();

  final List<AddedTextInfo> _addedTexts = [];
  final List<AddedImageInfo> _addedImages = [];
  int _currentIndex = 0;
  bool _loading = false;
  bool _editingText = false;

  @override
  void initState() {
    super.initState();
    _imgFile = widget.imgFile;
  }

  void _pickImage() async {
    final _pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (_pickedImage != null) {
      setState(() {
        if (_imgFile == null) {
          _imgFile = _pickedImage;
        } else {
          _addNewImage(_pickedImage);
        }
      });
    }
  }

  void _saveToGallery(BuildContext context) async {
    setState(() {
      _loading = true;
    });
    try {
      final _img = await _screenshotController.capture();

      if (_img == null) return;

      Directory tempDir = await getTemporaryDirectory();
      final _tempPath = tempDir.path;

      final _imgFile = await File(
        '$_tempPath/my_image.png',
      ).writeAsBytes(_img);
    } catch (e) {
      debugPrint(e.toString());
    }
    setState(() {
      _loading = false;
    });
  }

  void _removeText(BuildContext context) {
    setState(() {
      _addedTexts.removeAt(_currentIndex);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Deleted',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  void _removeImage(BuildContext context) {
    setState(() {
      _addedImages.removeAt(_currentIndex);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Deleted',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  void _setCurrentIndex(BuildContext context, index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _changeTextColor(Color color) {
    setState(() {
      _addedTexts[_currentIndex].color = color;
    });
  }

  void _changeBgColor() {
    setState(() {
      if (_addedTexts[_currentIndex].bgColor == kcWhite) {
        _addedTexts[_currentIndex].bgColor = Colors.transparent;
      } else {
        _addedTexts[_currentIndex].bgColor = kcWhite;
      }
    });
  }

  void _increaseFontSize() {
    setState(() {
      _addedTexts[_currentIndex].fontSize += 2;
    });
  }

  void _decreaseFontSize() {
    setState(() {
      _addedTexts[_currentIndex].fontSize -= 2;
    });
  }

  void _alignLeft() {
    setState(() {
      _addedTexts[_currentIndex].textAlign = TextAlign.left;
    });
  }

  void _alignCenter() {
    setState(() {
      _addedTexts[_currentIndex].textAlign = TextAlign.center;
    });
  }

  void _alignRight() {
    setState(() {
      _addedTexts[_currentIndex].textAlign = TextAlign.right;
    });
  }

  void _boldText() {
    setState(() {
      if (_addedTexts[_currentIndex].fontWeight == FontWeight.bold) {
        _addedTexts[_currentIndex].fontWeight = FontWeight.normal;
      } else {
        _addedTexts[_currentIndex].fontWeight = FontWeight.bold;
      }
    });
  }

  void _italicText() {
    setState(() {
      if (_addedTexts[_currentIndex].fontStyle == FontStyle.italic) {
        _addedTexts[_currentIndex].fontStyle = FontStyle.normal;
      } else {
        _addedTexts[_currentIndex].fontStyle = FontStyle.italic;
      }
    });
  }

  void _addLinesToText() {
    setState(() {
      if (_addedTexts[_currentIndex].text.contains('\n')) {
        _addedTexts[_currentIndex].text =
            _addedTexts[_currentIndex].text.replaceAll('\n', ' ');
      } else {
        _addedTexts[_currentIndex].text =
            _addedTexts[_currentIndex].text.replaceAll(' ', '\n');
      }
    });
  }

  void _addNewText(BuildContext context) {
    setState(() {
      _editingText = true;
      _addedTexts.add(
        AddedTextInfo(
          text: _textEditingController.text,
          left: 0,
          top: 0,
          color: Colors.black,
          bgColor: Colors.white,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          fontSize: 20,
          textAlign: TextAlign.left,
        ),
      );

      _textEditingController.clear();
      Navigator.of(context).pop();
    });
  }

  void _addNewImage(final XFile img) {
    setState(() {
      _addedImages.add(
        AddedImageInfo(
          left: 0,
          top: 0,
          img: img,
          width: 100.0,
          height: 100.0,
        ),
      );
    });
  }

  void _addNewTextDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          'Add New Text',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        content: TextField(
          controller: _textEditingController,
          decoration: const InputDecoration(
            suffixIcon: Icon(
              Icons.edit,
            ),
            filled: true,
            hintText: 'Your Text Here..',
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              bottom: 8.0,
              right: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MemeButton.bordered(
                  'Done',
                  padding: const EdgeInsets.all(0.0),
                  onPressed: () {
                    _addNewText(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcBlack,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                left: 10.0,
                right: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    color: kcWhite,
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                    ),
                  ),
                  _loading
                      ? const SizedBox(
                          width: 30.0,
                          height: 30.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                            color: kcWhite,
                          ),
                        )
                      : _editingText
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  _editingText = false;
                                });
                              },
                              icon: const Icon(
                                Icons.check_rounded,
                              ),
                              color: kcWhite,
                            )
                          : const SizedBox(),
                ],
              ),
            ),
            Expanded(
              child: Center(child: _imageBuilder()),
            ),
            const Divider(),
            _editingText ? _actionsAfterTextAdd() : _actionsBuilder(),
            const SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageBuilder() {
    if (_imgFile == null) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _pickImage,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.add_rounded,
                color: kcWhite,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Add Image',
                style: TextStyle(
                  fontSize: 14.0,
                  color: kcWhite,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Screenshot(
      controller: _screenshotController,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Image.file(
                        File(_imgFile!.path),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ..._addedImagesBuilder(),
          ..._addedTextsBuilder(),
          _creatorText.text.isNotEmpty
              ? Positioned(
                  left: 0,
                  bottom: 0,
                  child: Text(
                    _creatorText.text,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(
                          0.3,
                        )),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  List<Widget> _addedImagesBuilder() {
    final _list = <Widget>[];
    for (int i = 0; i < _addedImages.length; i++) {
      final _addedImage = _addedImages[i];
      final _widget = Positioned(
        left: _addedImage.left,
        top: _addedImage.top,
        child: GestureDetector(
          onLongPress: () {
            setState(() {
              _currentIndex = i;
            });
          },
          onTap: () => _setCurrentIndex(context, i),
          child: Draggable(
            childWhenDragging: const SizedBox(),
            feedback: AddedImage(imgInfo: _addedImage),
            child: AddedImage(imgInfo: _addedImage),
            onDragEnd: (drag) {
              final renderBox = context.findRenderObject() as RenderBox;
              Offset off = renderBox.globalToLocal(drag.offset);
              setState(() {
                _addedImage.top = off.dy - 96;
                _addedImage.left = off.dx;
              });
            },
          ),
        ),
      );

      _list.add(_widget);
    }
    return _list;
  }

  List<Widget> _addedTextsBuilder() {
    final _list = <Widget>[];
    for (int i = 0; i < _addedTexts.length; i++) {
      final _addedText = _addedTexts[i];
      final _widget = Positioned(
        left: _addedText.left,
        top: _addedText.top,
        child: GestureDetector(
          onLongPress: () {
            setState(() {
              _currentIndex = i;
            });
          },
          onTap: () => _setCurrentIndex(context, i),
          child: Draggable(
            childWhenDragging: const SizedBox(),
            feedback: AddedText(textInfo: _addedText),
            child: AddedText(textInfo: _addedText),
            onDragEnd: (drag) {
              final renderBox = context.findRenderObject() as RenderBox;
              Offset off = renderBox.globalToLocal(drag.offset);
              setState(() {
                _addedText.top = off.dy - 96;
                _addedText.left = off.dx;
              });
            },
          ),
        ),
      );

      _list.add(_widget);
    }
    return _list;
  }

  Widget _actionsBuilder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () {
            _addNewTextDialog(context);
          },
          color: kcWhite,
          splashRadius: 25.0,
          icon: const Icon(
            Icons.text_increase_rounded,
          ),
        ),
        IconButton(
          onPressed: () {
            _pickImage();
          },
          color: kcWhite,
          splashRadius: 25.0,
          icon: const Icon(
            Icons.image_rounded,
          ),
        ),
      ],
    );
  }

  Widget _actionsAfterTextAdd() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                if (_addedTexts[_currentIndex].textAlign == TextAlign.left) {
                  _alignCenter();
                } else if (_addedTexts[_currentIndex].textAlign ==
                    TextAlign.center) {
                  _alignRight();
                } else if (_addedTexts[_currentIndex].textAlign ==
                    TextAlign.right) {
                  _alignLeft();
                }
              },
              splashRadius: 25.0,
              color: kcWhite,
              icon: Icon(
                _addedTexts[_currentIndex].textAlign == TextAlign.left
                    ? Icons.format_align_left_rounded
                    : _addedTexts[_currentIndex].textAlign == TextAlign.center
                        ? Icons.format_align_center_rounded
                        : Icons.format_align_right_rounded,
              ),
            ),
            IconButton(
              onPressed: () {
                _boldText();
              },
              splashRadius: 25.0,
              color: kcWhite,
              icon: Container(
                padding: const EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      _addedTexts[_currentIndex].fontWeight == FontWeight.bold
                          ? kcWhite
                          : Colors.transparent,
                ),
                child: Icon(
                  Icons.format_bold_rounded,
                  color:
                      _addedTexts[_currentIndex].fontWeight == FontWeight.bold
                          ? kcBlack
                          : kcWhite,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                _italicText();
              },
              splashRadius: 25.0,
              color: kcWhite,
              icon: Container(
                padding: const EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      _addedTexts[_currentIndex].fontStyle == FontStyle.italic
                          ? kcWhite
                          : Colors.transparent,
                ),
                child: Icon(
                  Icons.format_italic_rounded,
                  color:
                      _addedTexts[_currentIndex].fontStyle == FontStyle.italic
                          ? kcBlack
                          : kcWhite,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                _addLinesToText();
              },
              splashRadius: 25.0,
              color: kcWhite,
              icon: Container(
                padding: const EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _addedTexts[_currentIndex].text.contains('\n')
                      ? kcWhite
                      : Colors.transparent,
                ),
                child: Icon(
                  Icons.next_plan_outlined,
                  color: _addedTexts[_currentIndex].text.contains('\n')
                      ? kcBlack
                      : kcWhite,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                _changeBgColor();
              },
              splashRadius: 25.0,
              color: kcWhite,
              icon: Container(
                padding: const EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      _addedTexts[_currentIndex].bgColor == Colors.transparent
                          ? kcWhite
                          : Colors.transparent,
                ),
                child: Icon(
                  Icons.text_format_rounded,
                  color:
                      _addedTexts[_currentIndex].bgColor == Colors.transparent
                          ? kcBlack
                          : kcWhite,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                _decreaseFontSize();
              },
              splashRadius: 25.0,
              color: kcWhite,
              icon: const Icon(
                Icons.text_fields_rounded,
                color: kcWhite,
              ),
            ),
            IconButton(
              onPressed: () {
                _increaseFontSize();
              },
              splashRadius: 25.0,
              color: kcWhite,
              icon: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(pi),
                child: const Icon(
                  Icons.text_fields_rounded,
                  color: kcWhite,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                _addNewTextDialog(context);
              },
              color: kcWhite,
              splashRadius: 25.0,
              icon: const Icon(
                Icons.text_increase_rounded,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: _colorsBuilder(),
        ),
      ],
    );
  }

  Widget _colorsBuilder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _colorItemBuilder(Colors.white),
        _colorItemBuilder(Colors.black),
        _colorItemBuilder(Colors.red),
        _colorItemBuilder(Colors.green),
        _colorItemBuilder(Colors.yellow),
        _colorItemBuilder(Colors.purple),
        _colorItemBuilder(Colors.orange),
        _colorItemBuilder(Colors.grey),
        _colorItemBuilder(Colors.brown),
        _colorItemBuilder(Colors.pink),
      ],
    );
  }

  Widget _colorItemBuilder(final Color color) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _changeTextColor(color);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Container(
          width: 25.0,
          height: 25.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            border: Border.all(color: kcWhite),
          ),
        ),
      ),
    );
  }
}
