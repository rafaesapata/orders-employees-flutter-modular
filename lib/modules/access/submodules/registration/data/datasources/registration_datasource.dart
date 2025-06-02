import '../../domain/dtos/registration_dto.dart';

abstract class RegistrationDatasource {
  Future<void> register(RegistrationDTO registration);
}
