import 'package:meme_creator/views/widgets/common_widgets/meme_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MemeLottieBuilder extends StatelessWidget {
  final String animationUrl;
  final String? title;
  final String? description;
  final Widget? actionButton;

  const MemeLottieBuilder({
    Key? key,
    required this.animationUrl,
    this.title,
    this.description,
    this.actionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset(
          animationUrl,
          width: MediaQuery.of(context).size.width / 1.5,
        ),
        if (title != null)
          const SizedBox(
            height: 25.0,
          ),
        if (title != null) MemeText.heading3(title!),
        if (description != null)
          const SizedBox(
            height: 5.0,
          ),
        if (description != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: MemeText.body(
              description!,
              textAlign: TextAlign.center,
            ),
          ),
        if (actionButton != null)
          const SizedBox(
            height: 25.0,
          ),
        if (actionButton != null) actionButton!
      ],
    );
  }
}
