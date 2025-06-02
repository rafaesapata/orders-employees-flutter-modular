import '../../../domain/entities/session_token_entity.dart';
import '../../models/session_token_model.dart';
import 'secure_storage_provider.dart';

abstract class SessionProvider {
  Future<bool> put(SessionTokenEntity value);
  Future<SessionTokenEntity?> get();
  Future<bool> destroy();
}

class SessionProviderImp extends SessionProvider {
  final SecureStorageProvider _localStorage;
  final key = 'app-session';

  SessionProviderImp({
    required SecureStorageProvider localStorage,
  }) : _localStorage = localStorage;

  @override
  Future<bool> put(SessionTokenEntity value) async =>
      await _localStorage.write(key, value.toJson());

  @override
  Future<SessionTokenEntity?> get() async {
    final result = await _localStorage.read(key);
    return result == null ? null : SessionTokenModel.fromJson(result);
  }

  @override
  Future<bool> destroy() async => await _localStorage.delete(key);
}
