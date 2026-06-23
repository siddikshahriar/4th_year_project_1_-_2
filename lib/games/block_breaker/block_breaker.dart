import 'dart:math';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:project_2/games/number_matching/number_tile.dart';
import 'block_breaker_world.dart';

class BlockBreaker extends FlameGame {
  int level;
  BlockBreaker({required this.level});

  @override
  Future<void> onLoad() async {
    /// global viewport resolution
    camera.viewport = FixedResolutionViewport(resolution: Vector2(600, 1200));
    await loadLevel(level);
  }

  Future<void> loadLevel(int level) async {
    /// new world
    final newWorld = BlockBreakerWorld(level: 1);

    /// assigning new world to the in built world
    world = newWorld;

    ///new viewfinder for new world
    camera.viewfinder.position = Vector2(0, 0);
    camera.viewfinder.anchor = Anchor.center;
  }
}
