import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';
import 'package:secretsanta/presentation/widgets/bg_image.dart';
import 'package:secretsanta/presentation/widgets/glitch_made_by.dart';

@RoutePage()
class EndPage extends HookWidget {
  const EndPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animateLottie =
        useFuture(Future.delayed(const Duration(seconds: 2)).then((_) => true));
    return Scaffold(
      body: BackgroundImage(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FadeInDown(
                preferences: const AnimationPreferences(
                  offset: Duration(seconds: 1),
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: AutoSizeText(
                    "That's all folks!",
                    maxLines: 1,
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              ConstrainedBox(
                constraints:
                    const BoxConstraints(maxHeight: 600, maxWidth: 600),
                child: Lottie.asset(
                  "assets/lottie/christmas-tree.json",
                  animate: animateLottie.data == true,
                  repeat: false,
                ),
              ),
              FadeInUp(
                preferences: const AnimationPreferences(
                  offset: Duration(seconds: 5),
                ),
                child: OutlinedButton.icon(
                  onPressed: AutoRouter.of(context).popUntilRoot,
                  icon: const Icon(
                    Icons.chevron_left_rounded,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "START AGAIN",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SlideInUp(
                preferences: const AnimationPreferences(
                  offset: Duration(seconds: 1),
                ),
                child: const GlitchMadeBy(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
