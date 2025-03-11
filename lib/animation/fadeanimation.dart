// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum AniProps { opacity, translateY }

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation({required this.delay, required this.child});

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
      ..scene(duration: 500.milliseconds)
          .tween(AniProps.opacity, Tween(begin: 0.0, end: 1.0))
      ..scene(duration: 500.milliseconds)
          .tween(AniProps.translateY, Tween(begin: -30.0, end: 0.0), curve: Curves.easeOut);

    return PlayAnimationBuilder<Movie>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, value, child) => Opacity(
        opacity: value.get(AniProps.opacity),
        child: Transform.translate(
            offset: Offset(0, value.get(AniProps.translateY)), child: child),
      ),
    );
  }
}
