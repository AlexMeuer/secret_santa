import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:secretsanta/presentation/widgets/bg_image.dart';

class BlurredBackground extends StatelessWidget {
  const BlurredBackground({
    Key? key,
    this.background = const BackgroundImage(),
    required this.child,
  }) : super(key: key);

  final Widget background;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        background,
        ClipRect(
          child: Center(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}
