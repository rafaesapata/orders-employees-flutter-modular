import '../../domain/dtos/confirm_account_dto.dart';

abstract class ConfirmAccountDatasource {
  Future<void> confirmAccount(ConfirmAccountDTO request);
  Future<void> resendCode();
}
