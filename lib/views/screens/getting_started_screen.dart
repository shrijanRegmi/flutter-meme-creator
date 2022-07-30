import 'package:meme_creator/utils/app_routes.dart';
import 'package:meme_creator/views/widgets/common_widgets/meme_button.dart';
import 'package:meme_creator/views/widgets/common_widgets/meme_text.dart';
import 'package:flutter/material.dart';

class GettingStartedScreen extends StatelessWidget {
  const GettingStartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: _topBuilder(context),
          ),
          const SizedBox(
            height: 20.0,
          ),
          _bottomBuilder(context),
          const SizedBox(
            height: 30.0,
          ),
        ],
      ),
    );
  }

  Widget _topBuilder(final BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/getting_started.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _bottomBuilder(final BuildContext context) {
    return Column(
      children: [
        const MemeText.heading1(
          'Save your time\nand ideas',
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20.0,
        ),
        const MemeText.body(
          'Enjoy together, happy to share and save your\nideas - staying at home',
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 40.0,
        ),
        MemeButton.filled(
          'Get Started',
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRoutes.homeScreen,
            );
          },
          minWidth: 150.0,
          borderRadius: 10.0,
          padding: const EdgeInsets.all(15.0),
          shadow: true,
        ),
      ],
    );
  }
}
