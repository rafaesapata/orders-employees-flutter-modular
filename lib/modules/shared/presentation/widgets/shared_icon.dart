import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SharedIcon extends StatelessWidget {
  final String icon;
  final BoxFit? fit;
  final Color? color;
  final double? size;
  final double? width;
  final double? height;
  final Function()? onTap;

  const SharedIcon({
    super.key,
    required this.icon,
    this.fit,
    this.color,
    this.size,
    this.width,
    this.height,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: SvgPicture.asset(
          icon,
          fit: fit ?? BoxFit.none,
          colorFilter:
              color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn),
          width: size ?? width,
          height: size ?? height,
        ),
      );
}
