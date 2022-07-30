import 'package:meme_creator/utils/app_routes.dart';
import 'package:meme_creator/views/screens/getting_started_screen.dart';
import 'package:meme_creator/views/screens/home_screen.dart';
import 'package:meme_creator/views/screens/photo_editor_screen.dart';
import 'package:meme_creator/views/screens/splash_screen.dart';
import 'package:meme_creator/wrapper.dart';
import 'package:flutter/material.dart';

class MemeRouter {
  static Route buildRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.wrapper:
        return _prepareRoute(settings, const Wrapper());
      case AppRoutes.splashScreen:
        return _prepareRoute(settings, const SplashScreen());
      case AppRoutes.getStartedScreen:
        return _prepareRoute(settings, const GettingStartedScreen());
      case AppRoutes.homeScreen:
        return _prepareRoute(settings, const HomeScreen());
      case AppRoutes.photoEditorScreen:
        final _args = settings.arguments as PhotoEditorScreenArgs;
        return _prepareRoute(
          settings,
          PhotoEditorScreen(
            imgFile: _args.imgFile,
          ),
        );
      default:
        return _prepareRoute(settings, const GettingStartedScreen());
    }
  }

  static Route _prepareRoute(
    final RouteSettings settings,
    final Widget widget,
  ) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => widget,
    );
  }
}
