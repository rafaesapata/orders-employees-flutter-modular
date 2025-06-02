import '../../../../../../shared/data/models/user_model.dart';
import '../../../domain/dtos/login_dto.dart';
import '../login_datasource.dart';

class LoginDatasourceImp implements LoginDatasource {
  @override
  Future<UserModel> loginWithAPI({required LoginDTO login}) async {
    return await Future.delayed(const Duration(seconds: 1), () {
      return UserModel(
        fullName: 'Paulo Lima',
        maskedDocumentNumber: '***.456.789-**',
        birthdate: '2002-03-15',
        photoUrl: true,
        userName: true,
        email: 'paulo.lima@mail.com',
        cellPhone: '+55 11 91234-5678',
        passwordUpdatedDate: '2025-03-10T14:23:00Z',
        passwordErrorsAllowed: 5,
        id: 'user_001',
        isActive: true,
        createDate: '2024-11-01T09:30:00Z',
      );
    });
  }
}
