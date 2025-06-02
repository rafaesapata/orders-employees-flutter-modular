import 'dart:math';

import '../../../domain/dtos/registration_dto.dart';
import '../registration_datasource.dart';

class RegistrationDatasourceImp implements RegistrationDatasource {
  @override
  Future<void> register(RegistrationDTO registration) async {
    await Future.delayed(const Duration(seconds: 1), () {
      if (Random().nextInt(10) % 3 == 0) throw Exception('Erro de teste');
    });
  }
}
