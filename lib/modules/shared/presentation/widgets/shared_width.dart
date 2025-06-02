import 'package:flutter/material.dart';

class SharedWidth extends StatelessWidget {
  final double width;
  const SharedWidth(this.width, {super.key});

  @override
  Widget build(BuildContext context) => SizedBox(width: width);
}
