import 'package:flutter/material.dart';

class SharedSingleChildScrollView extends StatelessWidget {
  final Widget child;

  const SharedSingleChildScrollView({super.key, required this.child});

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: child,
      );
}
