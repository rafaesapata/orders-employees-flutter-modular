import 'package:flutter/material.dart';

class SharedHeight extends StatelessWidget {
  const SharedHeight(this.height, {super.key});
  final double height;

  @override
  Widget build(BuildContext context) => SizedBox(height: height);
}
