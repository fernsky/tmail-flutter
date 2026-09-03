import 'package:core/utils/web/key_value_storage_stub.dart';
import 'package:tmail_ui_user/features/caching/exceptions/local_storage_exception.dart';

class LocalStorageManager {

  final WebKeyValueStorage _localStorage = WebKeyValueStorage.local();

  void save(String key, String value) {
    _localStorage.setItem(key, value);
  }

  String get(String key) {
    final value = _localStorage.getItem(key);

    if (value != null) {
      return value;
    } else {
      throw const NotFoundDataWithThisKeyException();
    }
  }

  void remove(String key) {
    _localStorage.removeItem(key);
  }
}
