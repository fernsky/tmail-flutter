import 'package:core/utils/web/key_value_storage_stub.dart';
import 'package:tmail_ui_user/features/caching/exceptions/local_storage_exception.dart';

class SessionStorageManager {

  final WebKeyValueStorage sessionStorage = WebKeyValueStorage.session();

  void save(String key, String value) {
    sessionStorage.setItem(key, value);
  }

  String get(String key) {
    final value = sessionStorage.getItem(key);

    if (value != null) {
      return value;
    } else {
      throw const NotFoundDataWithThisKeyException();
    }
  }

  void remove(String key) {
    if (sessionStorage.containsKey(key)) {
      sessionStorage.removeItem(key);
    }
  }
}
