import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/domain/themes/shared_themes_colors.dart';
import '../controllers/splash_controller.dart';
import '../splash_animation_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  final _controller = Modular.get<SplashController>();

  Future<void> _initialize() async {
    final result = await _controller.init();
    Modular.to.pushReplacementNamed(result);
  }

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: SharedColors.brandMain,
          systemNavigationBarColor: SharedColors.brandMain,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        child: Scaffold(
          backgroundColor: SharedColors.brandMain,
          body: SplashAnimationWidget(callback: _initialize),
        ),
      );
}
