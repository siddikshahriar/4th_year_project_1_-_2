import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';
import 'block_breaker.dart';
import 'components/ball_component.dart';
import 'components/brick_component.dart';
import 'components/paddle_component.dart';
import 'components/star_component.dart';
import 'restart_overlay.dart';
import 'dart:convert';
import 'package:hive/hive.dart';

class BlockBreakerLevels {
  /// Returns levels from Hive cache (filled by LevelSyncService when online).
  /// Falls back to the bundled list below when offline with no cache yet.
  List<Level> get levelList {
    try {
      final raw = Hive.box('block_breaker_levels_box').get('levels');
      if (raw != null) {
        final list = jsonDecode(raw as String) as List<dynamic>;
        if (list.isNotEmpty) {
          return list.map<Level>((item) {
            final m      = item as Map<String, dynamic>;
            final layout = (m['layout'] as List<dynamic>)
                .map<List<int>>((r) => (r as List<dynamic>)
                .map((c) => (c as num).toInt())
                .toList())
                .toList();
            return Level(
              levelId: (m['level_id'] as num).toInt(),
              layout:  layout,
            );
          }).toList();
        }
      }
    } catch (_) {}
    return _bundled;
  }

  static final List<Level> _bundled = [
    Level(
      levelId: 1,
      layout: [
        [1, 1, 1, 1, 1, 1, 1, 1],
        [2, 2, 2, 2, 2, 2, 2, 2],
        [3, 3, 3, 3, 3, 3, 3, 3],
        [4, 4, 4, 4, 4, 4, 4, 4],
        [3, 3, 3, 3, 3, 3, 3, 3],
        [2, 2, 2, 2, 2, 2, 2, 2],
        [1, 1, 1, 1, 1, 1, 1, 1],
      ],
    ),
    Level(
      levelId: 2,
      layout: [
        [0, 1, 1, 1, 0],
        [1, 0, 1, 0, 1],
        [1, 1, 0, 1, 1],
        [1, 0, 0, 0, 1],
      ],
    ),
  ];
}

class Level {
  final int levelId;
  final List<List<int>> layout;

  Level({required this.levelId, required this.layout});
}
