import 'package:flutter/material.dart';

import '../../shared/domain/consts/shared_dimens.dart';
import '../../shared/domain/consts/shared_icons.dart';
import '../../shared/domain/extensions/shared_extensions_build_context.dart';
import '../../shared/domain/extensions/shared_extensions_string.dart';
import '../../shared/domain/themes/shared_themes_colors.dart';
import '../../shared/presentation/widgets/shared_width.dart';

class SplashAnimationWidget extends StatefulWidget {
  final VoidCallback callback;
  const SplashAnimationWidget({super.key, required this.callback});

  @override
  State<SplashAnimationWidget> createState() => _SplashAnimationWidgetState();
}

class _SplashAnimationWidgetState extends State<SplashAnimationWidget> {
  final _logoWidth = 101.0;
  final _fullLogoWidth = 280.0;

  final _opacityDuration = const Duration(milliseconds: 600);
  final _slideDelayDuration = const Duration(milliseconds: 1600);
  final _slideDuration = const Duration(seconds: 1);
  final _frozenDuration = const Duration(milliseconds: 4500);

  final _visible = ValueNotifier(false);
  final _centralized = ValueNotifier(true);

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () => _visible.value = true);
    Future.delayed(_slideDelayDuration, () => _centralized.value = false);
    Future.delayed(_frozenDuration, widget.callback);
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
        listenable: Listenable.merge([
          _visible,
          _centralized,
        ]),
        builder: (context, child) => Stack(
          children: [
            AnimatedPositioned(
              left: _centralized.value
                  ? (context.width / 2) - (_logoWidth / 2)
                  : ((context.width / 2) - (_fullLogoWidth / 2)),
              top: context.height / 2,
              duration: _slideDuration,
              curve: Curves.fastOutSlowIn,
              child: _logo,
            ),
          ],
        ),
      );

  Widget get _logo => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedOpacity(
            duration: _opacityDuration,
            opacity: _visible.value ? 1 : 0,
            child: SharedIcons.logo.icon(
              color: SharedColors.white,
              width: _logoWidth,
            ),
          ),
          const SharedWidth(SharedDimens.smallExtra),
          AnimatedOpacity(
            duration: _opacityDuration,
            opacity: !_centralized.value ? 1 : 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: SharedDimens.tiny),
                SharedIcons.logoTitle.icon(color: SharedColors.white),
                const SizedBox(height: SharedDimens.tiny),
                SharedIcons.logoSubtitle.icon(color: SharedColors.white),
              ],
            ),
          ),
        ],
      );
}
