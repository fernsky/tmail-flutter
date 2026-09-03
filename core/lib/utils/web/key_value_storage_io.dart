/// Non-web platforms never instantiate this (every caller is reached only
/// from web-gated code paths), so this just satisfies the
/// conditional-export contract without pulling in a web-only package.
class WebKeyValueStorage {
  WebKeyValueStorage.local();
  WebKeyValueStorage.session();

  String? getItem(String key) => null;

  void setItem(String key, String value) {}

  void removeItem(String key) {}

  bool containsKey(String key) => false;

  List<MapEntry<String, String>> get entries => const [];
}
