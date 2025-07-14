import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mela/data/securestorage/constants/secure_storage_const.dart';

class SecureStorageHelper{
  final FlutterSecureStorage _secureStorage;

  //Constructor
  SecureStorageHelper(this._secureStorage);

  //General Methods:------------------------------------------------------------
  Future<String?> get accessToken async{
    return await _secureStorage.read(key: SecureStorageConst.accessToken);
  }

  Future<String?> get refreshToken async{
    return await _secureStorage.read(key: SecureStorageConst.refreshToken);
  }

  Future<void> saveAccessToken(String token) async{
    await _secureStorage.write(key: SecureStorageConst.accessToken, value: token);
  }

  Future<void> saveRefreshToken(String token) async{
    await _secureStorage.write(key: SecureStorageConst.refreshToken, value: token);
  }

  Future<void> deleteToken(String key) async{
    await _secureStorage.delete(key: key);
  }

  Future<void> deleteTokens() async{
    await _secureStorage.delete(key: SecureStorageConst.accessToken);
    await _secureStorage.delete(key: SecureStorageConst.refreshToken);
  }

  Future<void> deleteAll() async{
    await _secureStorage.deleteAll();
  }
}