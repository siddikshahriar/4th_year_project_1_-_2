import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'block_breaker.dart'; // Import your FlameGame class

class GameScreen extends StatelessWidget {
  final int level;
  const GameScreen({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold gives you an automatic back button over the game canvas
      appBar: AppBar(
        title: Text('NeuroGym - Level $level'),
        backgroundColor: const Color(0xFF1A1D24),
      ),
      body: GameWidget(
        // Pass the level dynamically to your Flame Game instance
        game: BlockBreaker(level: level),
      ),
    );
  }
}
