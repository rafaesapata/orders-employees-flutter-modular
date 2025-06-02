import '../../../../../shared/data/models/user_model.dart';
import '../../domain/dtos/login_dto.dart';

abstract class LoginDatasource {
  Future<UserModel> loginWithAPI({required LoginDTO login});
}
