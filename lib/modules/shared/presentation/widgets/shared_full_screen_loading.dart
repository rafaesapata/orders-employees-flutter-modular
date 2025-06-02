import 'package:flutter/material.dart';

import '../../domain/extensions/shared_extensions_build_context.dart';
import '../../domain/themes/shared_themes_colors.dart';

class SharedFullScreenLoading extends StatelessWidget {
  final double? width;
  final double? height;

  const SharedFullScreenLoading({
    super.key,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) => Container(
        color: SharedColors.background.withAlpha(200),
        width: width ?? context.width,
        height: height ?? context.height,
        child: Center(
          child: CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation<Color>(
              SharedColors.brandMain,
            ),
          ),
        ),
      );
}
