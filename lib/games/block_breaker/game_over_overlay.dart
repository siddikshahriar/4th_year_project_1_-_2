import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';
import 'world.dart';
import 'package:go_router/go_router.dart';

/// Full-screen overlay triggered on game completion or failure.
/// Renders a beautiful visual menu card and handles redirection to the main dashboard.
class GameOverOverlay extends PositionComponent with TapCallbacks {
  final BlockBreakerWorld world;
  final String title;
  final String subtitle;

  GameOverOverlay({
    required this.world,
    required this.title,
    required this.subtitle,
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size, anchor: Anchor.topLeft) {
    priority = 100; // Keep it on top of game components
  }

  @override
  void render(Canvas canvas) {
    final rect = size.toRect();

    // 1. Full screen dimmed backdrop blur effect
    canvas.drawRect(
      rect,
      Paint()
        ..color = Colors.black.withAlpha(
          190,
        ), // Smooth 75% opacity dark background
    );

    // 2. Draw a stylish centralized display panel card
    final panelWidth = size.x * 0.8;
    final panelHeight = size.y * 0.4;
    final panelRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(size.x / 2, size.y / 2),
        width: panelWidth,
        height: panelHeight,
      ),
      const Radius.circular(24), // Elegant rounded corners
    );

    // Draw panel background
    canvas.drawRRect(
      panelRect,
      Paint()
        ..color = const Color(0xFF1E272C).withAlpha(240), // Dark slate panel
    );

    // Draw an accent border around the panel
    canvas.drawRRect(
      panelRect,
      Paint()
        ..color =
            const Color(0xFF341F97) // Royal purple edge glow
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5,
    );

    // 3. Render Title Text
    TextPaint(
      style: const TextStyle(
        color: Colors.white,
        fontSize: 32,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
      ),
    ).render(
      canvas,
      title.toUpperCase(),
      Vector2(size.x / 2, size.y / 2 - (panelHeight * 0.25)),
      anchor: Anchor.center,
    );

    // 4. Render Subtitle Text (Golden Accent)
    TextPaint(
      style: const TextStyle(
        color: Color(0xFFD4AF37), // Metallic trophy gold color code
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ).render(
      canvas,
      subtitle,
      Vector2(size.x / 2, size.y / 2 - (panelHeight * 0.02)),
      anchor: Anchor.center,
    );

    // 5. Render Redirection Navigation Prompt
    TextPaint(
      style: const TextStyle(
        color: Color(0xFF2ED573), // Vibrant green button text style
        fontSize: 16,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    ).render(
      canvas,
      'TAP TO RETURN TO DASHBOARD',
      Vector2(size.x / 2, size.y / 2 + (panelHeight * 0.25)),
      anchor: Anchor.center,
    );
  }

  @override
  void onTapUp(TapUpEvent event) {
    // 1. Clean up or pause engine worlds if needed via game reference context
    final gameContext = world.game.buildContext;

    if (gameContext != null && gameContext.mounted) {
      Navigator.of(gameContext).pop();
    }
  }
}
