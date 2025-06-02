import '../../domain/entities/user_entity.dart';

abstract class SharedDatasource {
  Future<UserEntity> fetchUserData();
  Future<bool> requestStoragePermission();
}
