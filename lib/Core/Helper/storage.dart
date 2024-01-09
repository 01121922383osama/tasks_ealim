import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  Future<void> save(String key, String value) async {
    await secureStorage.write(key: key, value: value);
  }

  Future<String?> read(String key) async {
    return await secureStorage.read(key: key);
  }

  Future<void> delete(String key) async {
    await secureStorage.delete(key: key);
  }

  Future<void> clear() async {
    await secureStorage.deleteAll();
  }

  Future<bool> contains(String key) async {
    return await secureStorage.containsKey(key: key);
  }
}
