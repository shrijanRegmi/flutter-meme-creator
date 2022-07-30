import 'package:meme_creator/utils/app_colors.dart';
import 'package:flutter/material.dart';

enum _Type {
  filled,
  bordered,
}

class MemeButton extends StatelessWidget {
  final String value;
  final _Type _type;
  final Color color;
  final TextStyle? textStyle;
  final double? minWidth;
  final double borderRadius;
  final EdgeInsets? padding;
  final Function()? onPressed;
  final bool shadow;

  const MemeButton.filled(
    this.value, {
    Key? key,
    this.onPressed,
    this.color = kcPrimaryDark,
    this.textStyle,
    this.minWidth,
    this.borderRadius = 5.0,
    this.padding,
    this.shadow = false,
  })  : _type = _Type.filled,
        super(key: key);

  const MemeButton.bordered(
    this.value, {
    Key? key,
    this.onPressed,
    this.color = kcPrimaryDark,
    this.textStyle,
    this.minWidth,
    this.borderRadius = 5.0,
    this.padding,
    this.shadow = false,
  })  : _type = _Type.bordered,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _type == _Type.filled ? _filledBuilder() : _borderedBuilder();
  }

  Widget _filledBuilder() {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      minWidth: minWidth,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      elevation: shadow ? 7.0 : 0.0,
      padding: padding,
      disabledColor: kcLightGrey,
      child: Text(
        value,
        style: textStyle ??
            const TextStyle(
              color: Colors.white,
            ),
      ),
    );
  }

  Widget _borderedBuilder() {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: minWidth,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: BorderSide(color: color),
      ),
      elevation: shadow ? 7.0 : 0.0,
      padding: padding,
      highlightColor: Colors.transparent,
      focusColor: color.withOpacity(0.2),
      hoverColor: color.withOpacity(0.2),
      splashColor: color.withOpacity(0.2),
      disabledColor: kcLightGrey,
      child: Text(
        value,
        style: textStyle ??
            TextStyle(
              color: color,
            ),
      ),
    );
  }
}
