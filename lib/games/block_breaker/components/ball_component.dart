import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class BallComponent extends CircleComponent {
  Vector2 velocity = Vector2.zero();
  bool isLaunched = false;
  double restOffsetX;

  BallComponent({
    required super.position,
    required double radius,
    this.restOffsetX = 0,
  }) : super(radius: radius, anchor: Anchor.center);

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(radius, radius), radius, paint);
  }
}
