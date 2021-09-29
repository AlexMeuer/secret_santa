import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';
import 'package:secretsanta/presentation/routes/auto_router.gr.dart';
import 'package:secretsanta/presentation/widgets/bg_image.dart';

class DrawPage extends HookWidget {
  DrawPage({
    Key? key,
    required this.index,
    required this.names,
    required this.drawNames,
  })  : fabAnimKey = GlobalKey<AnimatorWidgetState>(),
        revealAnimKey = GlobalKey<AnimatorWidgetState>(),
        super(key: key);

  final int index;
  final BuiltList<String> names;
  final BuiltList<int> drawNames;
  final GlobalKey<AnimatorWidgetState> fabAnimKey;
  final GlobalKey<AnimatorWidgetState> revealAnimKey;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final show = useState(false);
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        title: const Text("Don't let anyone else see!"),
      ),
      floatingActionButton: Pulse(
        key: fabAnimKey,
        preferences: const AnimationPreferences(
          autoPlay: AnimationPlayStates.None,
        ),
        child: FloatingActionButton.extended(
          tooltip: show.value ? null : "Reveal before continuing.",
          onPressed: show.value
              ? () => index + 1 >= names.length
                  ? AutoRouter.of(context).push(const EndPageRoute())
                  : AutoRouter.of(context).push(
                      DrawPageRoute(
                        index: index + 1,
                        names: names,
                        drawNames: drawNames,
                      ),
                    )
              : null,
          icon: const Icon(Icons.chevron_right_rounded),
          label: const Text("NEXT"),
          backgroundColor: show.value ? null : Colors.grey,
        ),
      ),
      body: Stack(
        children: [
          BackgroundImage(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: AutoSizeText(
                      names[index],
                      style: theme.textTheme.headline1
                          ?.copyWith(color: Colors.white),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Tada(
                    key: revealAnimKey,
                    preferences: const AnimationPreferences(
                      autoPlay: AnimationPlayStates.None,
                    ),
                    child: ElevatedButton(
                      onPressed: show.value
                          ? null
                          : () {
                              show.value = true;
                              // Loop the animation with a delay.
                              fabAnimKey.currentState?.animator?.controller
                                  ?.addStatusListener((status) {
                                if (status != AnimationStatus.completed) return;
                                animateFabAfterDelay();
                              });
                              animateFabAfterDelay();
                              revealAnimKey.currentState?.animator?.forward();
                            },
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(minWidth: 200),
                        child: AutoSizeText(
                          show.value ? names[drawNames[index]] : "DRAW",
                          style: theme.textTheme.headline2
                              ?.copyWith(color: Colors.white),
                          maxLines: 1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          IgnorePointer(
            child: Align(
              alignment: const Alignment(0.0, 0.8),
              child: Lottie.asset(
                "assets/lottie/confetti.json",
                repeat: false,
                animate: show.value,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void animateFabAfterDelay() {
    Future.delayed(const Duration(seconds: 2)).then(
      (_) => fabAnimKey.currentState?.animator?.forward(),
    );
  }
}
