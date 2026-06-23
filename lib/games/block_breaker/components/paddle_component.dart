import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class PaddleComponent extends PositionComponent {
  // Movement is driven by BlockBreakerWorld via the full-arena InputLayer,
  // so this component just needs to render itself.
  PaddleComponent({required super.position, required super.size})
    : super(anchor: Anchor.center);

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = const Color(0xFF54A0FF);
    canvas.drawRRect(
      RRect.fromRectAndRadius(size.toRect(), const Radius.circular(6)),
      paint,
    );
  }
}
