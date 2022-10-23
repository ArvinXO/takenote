import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

enum AniProps { opacity, translateY }

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimation({Key? key, required this.delay, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tween = MovieTween()
      ..scene(duration: const Duration(milliseconds: 700))
          .tween(AniProps.opacity, Tween<double>(begin: 0.0, end: 1))
          .tween(AniProps.translateY, Tween<double>(begin: -10, end: 0));

    return PlayAnimationBuilder<Movie>(
      tween: tween,
      curve: Curves.easeOut,
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      child: child,
      builder: (context, value, child) => Opacity(
        opacity: value.get(AniProps.opacity),
        child: Transform.translate(
            offset: Offset(0, value.get(AniProps.translateY)), child: child),
      ),
    );
  }
}
