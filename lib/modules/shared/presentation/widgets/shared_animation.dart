import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

import '../../domain/consts/shared_animations.dart';
import '../../domain/consts/shared_dimens.dart';

class SharedAnimation extends StatelessWidget {
  final Key? animationKey;
  final String? animation;
  final double? height;
  final double? width;
  final bool? repeat;
  final bool? reverse;
  final BoxFit? fit;
  final AnimationController? controller;

  const SharedAnimation({
    this.animationKey,
    this.animation,
    this.repeat = true,
    this.reverse = false,
    this.height = SharedDimens.huge,
    this.width = SharedDimens.huge,
    this.controller,
    this.fit,
  }) : super(key: animationKey);

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        child: Lottie.asset(
          animation ?? SharedAnimations.load,
          height: height,
          width: width,
          alignment: Alignment.center,
          repeat: repeat,
          reverse: reverse,
          fit: fit ?? BoxFit.cover,
          controller: controller,
          onLoaded: (composition) {
            if (controller != null) {
              controller!
                ..duration = composition.duration
                ..forward();
            }
          },
        ),
      );
}
