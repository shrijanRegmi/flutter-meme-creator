import 'package:flutter/material.dart';

class DialogHelper {
  final BuildContext context;
  DialogHelper(this.context);

  Future showBottomSheet({
    required final Widget widget,
    final double borderRadius = 0.0,
    final bool isScrollControlled = false,
  }) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
      ),
      isScrollControlled: isScrollControlled,
      builder: (context) => widget,
    );
  }
}
