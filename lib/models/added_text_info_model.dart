import 'package:flutter/material.dart';

class AddedTextInfo {
  String text;
  double left;
  double top;
  Color color;
  Color bgColor;
  FontWeight fontWeight;
  FontStyle fontStyle;
  double fontSize;
  TextAlign textAlign;

  AddedTextInfo({
    required this.text,
    required this.left,
    required this.top,
    required this.color,
    required this.bgColor,
    required this.fontWeight,
    required this.fontStyle,
    required this.fontSize,
    required this.textAlign,
  });
}
