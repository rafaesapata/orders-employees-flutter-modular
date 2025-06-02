import 'package:flutter/material.dart';

class SharedImage extends StatelessWidget {
  final String image;
  final BoxFit? fit;
  final double? size;
  final double? height;
  final double? width;
  final Function()? onTap;

  const SharedImage(
    this.image, {
    super.key,
    this.fit,
    this.size,
    this.height,
    this.width,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Image.asset(
          image,
          width: size ?? width,
          height: size ?? height,
          fit: fit,
        ),
      );
}
