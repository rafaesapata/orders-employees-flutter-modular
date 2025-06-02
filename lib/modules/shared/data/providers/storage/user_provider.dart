import '../../../domain/entities/user_entity.dart';
import '../../models/user_model.dart';
import 'secure_storage_provider.dart';

abstract class UserProvider {
  Future<bool> put(UserEntity value);
  Future<UserEntity?> get();
  Future<bool> destroy();
}

class UserProviderImp extends UserProvider {
  final SecureStorageProvider _localStorage;
  final key = 'app-user';

  UserProviderImp({
    required SecureStorageProvider localStorage,
  }) : _localStorage = localStorage;

  @override
  Future<bool> put(UserEntity value) async =>
      await _localStorage.write(key, value.toJson());

  @override
  Future<UserEntity?> get() async {
    final result = await _localStorage.read(key);
    return result == null ? null : UserModel.fromJson(result);
  }

  @override
  Future<bool> destroy() async => await _localStorage.delete(key);
}
