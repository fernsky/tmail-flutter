import 'package:web/web.dart' as web;

/// Map-like wrapper around `package:web`'s `Storage` (raw `getItem`/
/// `setItem`/`removeItem`/`key(index)` JS API), matching the Map-like
/// surface dart:html's `Storage` used to expose directly (`.entries`,
/// `[]=`, `.remove`, `.containsKey`) so callers barely change.
class WebKeyValueStorage {
  WebKeyValueStorage.local() : _storage = web.window.localStorage;
  WebKeyValueStorage.session() : _storage = web.window.sessionStorage;

  final web.Storage _storage;

  String? getItem(String key) => _storage.getItem(key);

  void setItem(String key, String value) => _storage.setItem(key, value);

  void removeItem(String key) => _storage.removeItem(key);

  bool containsKey(String key) => _storage.getItem(key) != null;

  List<MapEntry<String, String>> get entries {
    final result = <MapEntry<String, String>>[];
    for (var i = 0; i < _storage.length; i++) {
      final key = _storage.key(i);
      if (key == null) continue;
      final value = _storage.getItem(key);
      if (value == null) continue;
      result.add(MapEntry(key, value));
    }
    return result;
  }
}
