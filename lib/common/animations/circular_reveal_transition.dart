import 'dart:math';

import 'package:flutter/cupertino.dart';

class CircularRevealTransition extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const CircularRevealTransition({required this.animation, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final center = Offset(constraints.maxWidth / 2, constraints.maxHeight / 2);
        final maxRadius = sqrt(pow(constraints.maxWidth / 2, 2) + pow(constraints.maxHeight / 2, 2));

        final circleRadius = Tween<double>(begin: 0.0, end: maxRadius).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        );

        return ClipPath(
          clipper: _CircleClipper(center: center, radius: circleRadius.value),
          child: child,
        );
      },
    );
  }
}

class _CircleClipper extends CustomClipper<Path> {
  final Offset center;
  final double radius;

  _CircleClipper({required this.center, required this.radius});

  @override
  Path getClip(Size size) {
    return Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius))
      ..close();
  }

  @override
  bool shouldReclip(covariant _CircleClipper oldClipper) {
    return oldClipper.radius != radius;
  }
}