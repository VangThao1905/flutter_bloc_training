import 'dart:io';

/// {@template cache}
/// The interface and models for an cache providing access to todos.
/// {@endtemplate}
class CacheClient {
  /// {@macro cache}
  CacheClient() : _cache = <String, Object>{};

  final Map<String, Object> _cache;

  void write<T extends Object>({required String key, required T value}) {
    _cache[key] = value;
  }

  T? read<T extends Object>({required String key}) {
    final value = _cache[key];
    if (value is T) return value;
    return null;
  }
}
