import 'package:flutter/material.dart';

import '../../../models/added_text_info_model.dart';

class AddedText extends StatelessWidget {
  final AddedTextInfo textInfo;
  const AddedText({
    Key? key,
    required this.textInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: textInfo.bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 5.0,
        ),
        child: Text(
          textInfo.text,
          textAlign: textInfo.textAlign,
          style: TextStyle(
            fontSize: textInfo.fontSize,
            fontWeight: textInfo.fontWeight,
            fontStyle: textInfo.fontStyle,
            color: textInfo.color,
          ),
        ),
      ),
    );
  }
}
