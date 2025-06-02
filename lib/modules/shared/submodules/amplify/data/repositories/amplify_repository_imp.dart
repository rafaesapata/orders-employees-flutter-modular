import 'package:result_dart/result_dart.dart';

import '../../../rest/domain/failures/rest_failure.dart';
import '../../../rest/domain/failures/rest_failure_session_not_found.dart';
import '../../../rest/domain/failures/rest_failure_unhandled.dart';
import '../../domain/dtos/amplify_sign_in_dto.dart';
import '../../domain/entities/amplify_response_session_entity.dart';
import '../../domain/entities/amplify_response_sign_in_entity.dart';
import '../../domain/repositories/amplify_repository.dart';
import '../datasources/amplify_datasource.dart';

class AmplifyRepositoryImp implements AmplifyRepository {
  final AmplifyDatasource _amplifyDatasource;

  AmplifyRepositoryImp({
    required AmplifyDatasource amplifyDatasource,
  }) : _amplifyDatasource = amplifyDatasource;

  @override
  AsyncResult<Unit, RestFailure> initializeCognito() async {
    try {
      await _amplifyDatasource.initializeCognito();
      return unit.toSuccess();
    } on RestFailure catch (e) {
      return e.toFailure();
    } catch (e) {
      return RestFailureUnhandled(message: e.toString()).toFailure();
    }
  }

  @override
  AsyncResult<AmplifyResponseSignInEntity, RestFailure> signInCognito(
    AmplifySignInDto request,
  ) async {
    try {
      final result = await _amplifyDatasource.signIn(request);
      return result.toSuccess();
    } on RestFailure catch (e) {
      return e.toFailure();
    } catch (e) {
      return RestFailureUnhandled(message: e.toString()).toFailure();
    }
  }

  @override
  AsyncResult<AmplifyResponseSessionEntity, RestFailure> getSession() async {
    try {
      final result = await _amplifyDatasource.getSession();
      return result.toSuccess();
    } on RestFailure catch (e) {
      return e.toFailure();
    } catch (e) {
      return RestFailureSessionNotFound().toFailure();
    }
  }

  @override
  AsyncResult<String, RestFailure> getToken() async {
    try {
      final result = await _amplifyDatasource.getToken();
      return result.toSuccess();
    } on RestFailure catch (e) {
      return e.toFailure();
    } catch (e) {
      return RestFailureUnhandled(message: e.toString()).toFailure();
    }
  }

  @override
  AsyncResult<Unit, RestFailure> signOut() async {
    try {
      await _amplifyDatasource.signOut();
      return unit.toSuccess();
    } on RestFailure catch (e) {
      return e.toFailure();
    } catch (e) {
      return RestFailureUnhandled(message: e.toString()).toFailure();
    }
  }

  @override
  AsyncResult<bool, RestFailure> isLogged() async {
    try {
      final result = await _amplifyDatasource.getIsLogged();
      return result.toSuccess();
    } on RestFailure catch (e) {
      return e.toFailure();
    } catch (e) {
      return RestFailureUnhandled(message: e.toString()).toFailure();
    }
  }
}
