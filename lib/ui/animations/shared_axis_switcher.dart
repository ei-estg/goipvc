import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class SharedAxisSwitcher extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final SharedAxisTransitionType type;
  final bool reverse;

  const SharedAxisSwitcher({
    super.key,
    required this.child,
    required this.duration,
    required this.type,
    this.reverse = false
  });

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      reverse: reverse,
      duration: duration,
      transitionBuilder: (
          Widget child,
          Animation<double> primaryAnimation,
          Animation<double> secondaryAnimation,
          ) {
        return SharedAxisTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          transitionType: type,
          child: child,
        );
      },
      child: child,
    );
  }
}