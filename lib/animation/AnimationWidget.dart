import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

// Applies the fade and translate animation
class WidgetFadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  WidgetFadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    return PlayAnimationBuilder<double>(
      // Delay the animation
      delay: Duration(milliseconds: (200 * delay).round()),
      duration: Duration(milliseconds: 300),
      tween: Tween(begin: 0.5, end: 1.0),

      // Code adapted from Yassein, 2020
      // Apply the animation to the child
      builder: (context, animationValue, child) {
        return Opacity(
          opacity: animationValue,  // Apply opacity
          child: Transform.translate(
            // Move the widget vertically
            offset: Offset(0, 10 * (1 - animationValue)),  // Apply translation
            child: child,
          ),
        );
      },
      // End of adapted code
      child: child,
    );
  }
}
