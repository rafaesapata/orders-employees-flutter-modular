import 'package:result_dart/result_dart.dart';

import '../../submodules/rest/domain/failures/rest_failure.dart';
import '../../submodules/rest/domain/failures/rest_failure_not_found.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/shared_repository.dart';
import '../datasource/shared_datasource.dart';
import '../providers/storage/user_provider.dart';

class SharedRepositoryImp implements SharedRepository {
  final SharedDatasource _sharedDatasource;
  final UserProvider _userProvider;

  SharedRepositoryImp({
    required SharedDatasource sharedDatasource,
    required UserProvider userProvider,
  })  : _sharedDatasource = sharedDatasource,
        _userProvider = userProvider;

  @override
  AsyncResult<UserEntity, RestFailure> fetchRemoteUserData() async {
    try {
      final data = await _sharedDatasource.fetchUserData();
      return data.toSuccess();
    } on RestFailure catch (e) {
      return e.toFailure();
    } catch (e, s) {
      return RestFailure.fromError(e: e, stackTrace: s).toFailure();
    }
  }

  @override
  AsyncResult<UserEntity, RestFailure> fetchLocalUserData() async {
    try {
      final data = await _userProvider.get();
      if (data == null) {
        return RestFailureNotFound().toFailure();
      } else {
        return data.toSuccess();
      }
    } on RestFailure catch (e) {
      return e.toFailure();
    } catch (e, s) {
      return RestFailure.fromError(e: e, stackTrace: s).toFailure();
    }
  }

  @override
  AsyncResult<bool, RestFailure> requestStoragePermission() async {
    try {
      final data = await _sharedDatasource.requestStoragePermission();
      return data.toSuccess();
    } on RestFailure catch (e) {
      return e.toFailure();
    } catch (e, s) {
      return RestFailure.fromError(e: e, stackTrace: s).toFailure();
    }
  }
}
