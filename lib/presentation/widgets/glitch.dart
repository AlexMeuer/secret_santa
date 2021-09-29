/// Source: https://github.com/kherel/flutter_fun/blob/master/lib/glitch/glitch.dart
/// https://github.com/kherel/flutter_fun provides no license at time of copy-paste.
/// Slightly modified.
import 'dart:async';
import 'dart:math' as math;
import 'dart:math';

import 'package:flutter/material.dart';

MaterialAccentColor getRandomColor() => [
      Colors.blueAccent,
      Colors.redAccent,
      Colors.greenAccent,
    ][Random().nextInt(3)];

class GlitchEffect extends StatefulWidget {
  const GlitchEffect({
    Key? key,
    required this.child,
    this.minPeriod = const Duration(seconds: 3),
    this.maxExtraPeriod = Duration.zero,
    this.minGlitchDuration = const Duration(milliseconds: 400),
    this.maxGlitchDuration = const Duration(milliseconds: 600),
  }) : super(key: key);

  final Widget child;
  final Duration minPeriod;
  final Duration maxExtraPeriod;
  final Duration minGlitchDuration;
  final Duration maxGlitchDuration;

  @override
  _GlitchEffectState createState() => _GlitchEffectState();
}

class _GlitchEffectState extends State<GlitchEffect>
    with SingleTickerProviderStateMixin {
  late GlitchController _controller;
  late Timer _timer;

  @override
  void initState() {
    _controller = GlitchController(duration: widget.minGlitchDuration);

    _timer = Timer.periodic(
      widget.minPeriod,
      (_) async {
        if (widget.maxExtraPeriod != Duration.zero) {
          final extraWaitMs = widget.maxExtraPeriod.inMilliseconds *
              random.nextDouble().toInt();
          if (extraWaitMs > 0) {
            await Future.delayed(Duration(milliseconds: extraWaitMs));
          }
        }
        _controller.duration = widget.minGlitchDuration +
            Duration(
              milliseconds: ((widget.maxGlitchDuration.inMilliseconds -
                          widget.minGlitchDuration.inMilliseconds) *
                      random.nextDouble())
                  .round(),
            );
        _controller
          ..reset()
          ..forward();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          final color = getRandomColor().withOpacity(0.5);
          if (!_controller.isAnimating) {
            return widget.child;
          }
          return Stack(
            children: [
              if (random.nextBool()) _clipedChild,
              Transform.translate(
                offset: randomOffset,
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: <Color>[
                        color,
                        color,
                      ],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.srcATop,
                  child: _clipedChild,
                ),
              ),
            ],
          );
        });
  }

  Offset get randomOffset => Offset(
        (random.nextInt(10) - 5).toDouble(),
        (random.nextInt(10) - 5).toDouble(),
      );
  Widget get _clipedChild => ClipPath(
        clipper: GlitchClipper(),
        child: widget.child,
      );
}

math.Random random = math.Random();

class GlitchClipper extends CustomClipper<Path> {
  final deltaMax = 15;
  final min = 3;

  @override
  Path getClip(Size size) {
    final path = Path();
    var y = randomStep;
    while (y < size.height) {
      final yRandom = randomStep;
      var x = randomStep;

      while (x < size.width) {
        final xRandom = randomStep;
        path.addRect(
          Rect.fromPoints(
            Offset(x, y),
            Offset(x + xRandom, y + yRandom),
          ),
        );
        x += randomStep * 2;
      }
      y += yRandom;
    }

    path.close();
    return path;
  }

  double get randomStep => min + random.nextInt(deltaMax).toDouble();

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}

class GlitchController extends Animation<int>
    with
        AnimationEagerListenerMixin,
        AnimationLocalListenersMixin,
        AnimationLocalStatusListenersMixin {
  GlitchController({required this.duration})
      : _value = 0,
        _status = AnimationStatus.dismissed;

  Duration duration;
  List<Timer> _timers = [];
  bool isAnimating = false;

  void forward() {
    isAnimating = true;
    final oneStep = (duration.inMicroseconds / 3).round();
    _status = AnimationStatus.forward;
    _timers = [
      Timer(
        Duration(microseconds: oneStep),
        () => value = 1,
      ),
      Timer(
        Duration(microseconds: oneStep * 2),
        () => value = 2,
      ),
      Timer(
        Duration(microseconds: oneStep * 3),
        () => value = 3,
      ),
      Timer(
        Duration(microseconds: oneStep * 4),
        () {
          _status = AnimationStatus.completed;
          isAnimating = false;
          notifyListeners();
        },
      ),
    ];
  }

  set value(int value) {
    _value = value;
    notifyListeners();
  }

  void reset() {
    _status = AnimationStatus.dismissed;
    _value = 0;
  }

  @override
  void dispose() {
    for (final timer in _timers) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  AnimationStatus get status => _status;
  AnimationStatus _status;

  @override
  int get value => _value;
  int _value;
}
