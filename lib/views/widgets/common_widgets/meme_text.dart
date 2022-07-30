import 'package:meme_creator/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class MemeText extends StatelessWidget {
  final String value;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextStyle defaultStyle;

  const MemeText.heading1(
    this.value, {
    Key? key,
    this.style,
    this.textAlign = TextAlign.start,
  })  : defaultStyle = ktsHeading1,
        super(key: key);

  const MemeText.heading2(
    this.value, {
    Key? key,
    this.style,
    this.textAlign = TextAlign.start,
  })  : defaultStyle = ktsHeading2,
        super(key: key);

  const MemeText.heading3(
    this.value, {
    Key? key,
    this.style,
    this.textAlign = TextAlign.start,
  })  : defaultStyle = ktsHeading3,
        super(key: key);

  const MemeText.title(
    this.value, {
    Key? key,
    this.style,
    this.textAlign = TextAlign.start,
  })  : defaultStyle = ktsTitle,
        super(key: key);

  const MemeText.body(
    this.value, {
    Key? key,
    this.style,
    this.textAlign = TextAlign.start,
  })  : defaultStyle = ktsBody,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: defaultStyle.merge(style),
      textAlign: textAlign,
    );
  }
}
