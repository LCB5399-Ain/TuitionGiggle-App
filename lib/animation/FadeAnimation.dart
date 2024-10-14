import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    return PlayAnimationBuilder<double>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: Duration(milliseconds: 500), tween: Tween(begin: 0.0, end: 1.0), // How the animation value will change
      builder: (context, opacityValue, child) {
        return Opacity(
          opacity: opacityValue,  // Apply animated opacity
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - opacityValue)),  // Apply animated translation
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
