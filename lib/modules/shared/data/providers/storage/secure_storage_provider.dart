import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorageProvider {
  Future<bool> write(String key, String value);
  Future<String?> read(String key);
  Future<bool> delete(String key);
}

class SecureStorageProviderImp implements SecureStorageProvider {
  final FlutterSecureStorage storage;

  SecureStorageProviderImp({required this.storage});

  @override
  Future<bool> delete(String key) async {
    try {
      await storage.delete(key: key);
      return true;
    } on Exception {
      return false;
    }
  }

  @override
  Future<String?> read(String key) async {
    try {
      return await storage.read(key: key);
    } on Exception {
      return null;
    }
  }

  @override
  Future<bool> write(String key, String value) async {
    try {
      await storage.write(key: key, value: value);
      return true;
    } on Exception {
      return false;
    }
  }
}
