import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Lottie.asset(
                'assets/lotties/loading.json',
              ),
              // const Positioned(
              //   bottom: 30.0,
              //   left: 0.0,
              //   right: 0.0,
              //   child: Center(
              //     child: MemeText.heading3(
              //       'Bluetooth Controller',
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
