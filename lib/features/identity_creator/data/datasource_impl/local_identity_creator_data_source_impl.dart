import 'dart:convert';

import 'package:core/domain/exceptions/web_session_exception.dart';
import 'package:core/utils/web/key_value_storage_stub.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/user_name.dart';
import 'package:model/extensions/account_id_extensions.dart';
import 'package:tmail_ui_user/features/caching/utils/cache_utils.dart';
import 'package:tmail_ui_user/features/identity_creator/data/datasource/identity_creator_data_source.dart';
import 'package:tmail_ui_user/features/identity_creator/data/model/identity_cache_model.dart';
import 'package:tmail_ui_user/features/identity_creator/domain/model/identity_cache.dart';
import 'package:tmail_ui_user/main/exceptions/thrower/exception_thrower.dart';

class LocalIdentityCreatorDataSourceImpl implements IdentityCreatorDataSource {
  LocalIdentityCreatorDataSourceImpl(this._exceptionThrower);

  final ExceptionThrower _exceptionThrower;
  final WebKeyValueStorage _sessionStorage = WebKeyValueStorage.session();

  static const sessionStorageKeyword = 'identityCreatorSessionStorage';

  @override
  Future<void> saveIdentityCacheOnWeb(
    AccountId accountId,
    UserName userName,
    {required IdentityCache identityCache}
  ) async {
    return Future.sync(() {
      final cacheKey = _generateTupleKey(accountId, userName);
      _sessionStorage.setItem(
        cacheKey,
        jsonEncode(IdentityCacheModel.fromDomain(identityCache).toJson()),
      );
    }).catchError(_exceptionThrower.throwException);
  }

  @override
  Future<IdentityCache> getIdentityCacheOnWeb(
    AccountId accountId,
    UserName userName
  ) async {
    return Future.sync(() {
      final cacheKey = _generateTupleKey(accountId, userName);
      final result = _sessionStorage.getItem(cacheKey);
      if (result != null) {
        return IdentityCacheModel.fromJson(jsonDecode(result));
      } else {
        throw const NotFoundInWebSessionException();
      }
    }).catchError(_exceptionThrower.throwException);
  }

  @override
  Future<void> removeIdentityCacheOnWeb() async {
    return Future.sync(() {
      final keysToRemove = _sessionStorage.entries
        .where((entry) => entry.key.startsWith(LocalIdentityCreatorDataSourceImpl.sessionStorageKeyword))
        .map((entry) => entry.key)
        .toList();
      for (final key in keysToRemove) {
        _sessionStorage.removeItem(key);
      }
    }).catchError(_exceptionThrower.throwException);
  }

  String _generateTupleKey(AccountId accountId, UserName userName) {
    return TupleKey(
      LocalIdentityCreatorDataSourceImpl.sessionStorageKeyword,
      accountId.asString,
      userName.value
    ).toString();
  }
}
