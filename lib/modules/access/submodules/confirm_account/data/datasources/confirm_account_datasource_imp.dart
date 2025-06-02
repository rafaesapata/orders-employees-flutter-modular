import '../../domain/dtos/confirm_account_dto.dart';
import 'confirm_account_datasource.dart';

class ConfirmAccountDatasourceImp implements ConfirmAccountDatasource {
  @override
  Future<void> confirmAccount(ConfirmAccountDTO request) async =>
      await Future.delayed(const Duration(seconds: 1));

  @override
  Future<void> resendCode() async =>
      await Future.delayed(const Duration(seconds: 1));
}
