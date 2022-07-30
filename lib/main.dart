import 'package:meme_creator/meme_router.dart';
import 'package:meme_creator/utils/app_colors.dart';
import 'package:meme_creator/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: kcPrimaryDark,
      statusBarColor: kcPrimaryDark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const BluetoothController());
}

class BluetoothController extends StatelessWidget {
  const BluetoothController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meme Creator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.nunito().fontFamily,
        colorScheme: ThemeData().colorScheme.copyWith(
              secondary: kcPrimaryDark,
              primary: kcPrimaryDark,
            ),
      ),
      initialRoute: AppRoutes.wrapper,
      onGenerateRoute: MemeRouter.buildRoute,
    );
  }
}
