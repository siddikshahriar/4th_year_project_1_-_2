import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Downloads the latest game levels from Supabase when online,
/// then caches them in Hive so the game always works offline too.
class LevelSyncService {
  static const String _pfBox  = 'path_finder_levels_box';
  static const String _bbBox  = 'block_breaker_levels_box';
  static const String _key    = 'levels';

  /// Call once on app startup (after Hive + Supabase are ready).
  /// If offline it does nothing — the Hive cache from last online
  /// session is used automatically.
  static Future<void> syncLevels() async {
    final results = await Connectivity().checkConnectivity();
    final isOnline = results.any((r) => r != ConnectivityResult.none);
    if (!isOnline) return;

    await _syncPathFinderLevels();
    await _syncBlockBreakerLevels();
  }

  static Future<void> _syncPathFinderLevels() async {
    try {
      final rows = await Supabase.instance.client
          .from('path_finder_levels')
          .select()
          .order('sort_order');
      await Hive.box(_pfBox).put(_key, jsonEncode(rows));
    } catch (_) {
      // Stay on cached data silently
    }
  }

  static Future<void> _syncBlockBreakerLevels() async {
    try {
      final rows = await Supabase.instance.client
          .from('block_breaker_levels')
          .select()
          .order('sort_order');
      await Hive.box(_bbBox).put(_key, jsonEncode(rows));
    } catch (_) {
      // Stay on cached data silently
    }
  }
}
