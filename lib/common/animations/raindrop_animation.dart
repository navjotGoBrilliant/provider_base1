import 'package:flutter/animation.dart';

class StaggeredRaindropAnimation {
  StaggeredRaindropAnimation(this.controller):

        dropSize = Tween<double>(begin: 0, end: maximumDropSize).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.2, curve: Curves.easeIn),
          ),
        ),

        dropPosition = Tween<double>(begin: 0, end: maximumRelativeDropY).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.2, 0.5, curve: Curves.easeIn),
          ),
        );

  final AnimationController controller;

  final Animation<double> dropSize;
  final Animation<double> dropPosition;

  static final double maximumDropSize = 20;
  static final double maximumRelativeDropY = 0.5;
}