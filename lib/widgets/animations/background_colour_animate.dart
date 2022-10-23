import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:takenote/constants/k_constants.dart';

enum AniProps { opacity, color }

class BackgroundColourAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const BackgroundColourAnimation(
      {Key? key, required this.delay, required this.child})
      : super(key: key);

  @override
  // animate background colour from kJungleGreen to kJungleGreenDark
  Widget build(BuildContext context) {
    var tween = MovieTween()
      ..scene(duration: const Duration(milliseconds: 700)).tween(
          AniProps.color,
          ColorTween(
              begin: kJungleDarkGreen.withOpacity(0.8), end: kOxfordBlue));

    return PlayAnimationBuilder<Movie>(
      tween: tween,
      curve: Curves.easeOut,
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      child: child,
      builder: (context, value, child) => Scaffold(
        backgroundColor: value.get(AniProps.color),
        body: child,
      ),
    );
  }
}
