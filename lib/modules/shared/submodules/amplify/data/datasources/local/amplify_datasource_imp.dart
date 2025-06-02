import 'dart:io';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import '../../../amplify_configuration.dart';
import '../../../domain/dtos/amplify_sign_in_dto.dart';
import '../../../domain/entities/amplify_response_sign_in_entity.dart';
import '../../models/amplify_response_session_model.dart';
import '../../models/amplify_response_sign_in_model.dart';
import '../amplify_datasource.dart';

class AmplifyDatasourceImp implements AmplifyDatasource {
  @override
  Future<void> initializeCognito() async {
    await Amplify.addPlugin(AmplifyAuthCognito());
    await Amplify.configure(AmplifyConfiguration.json);
  }

  @override
  Future<bool> getIsLogged() async {
    final authSession = await Amplify.Auth.fetchAuthSession();
    return authSession.isSignedIn;
  }

  @override
  Future<AmplifyResponseSessionModel> getSession() async {
    final cognitoPlugin = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
    final authSession = await cognitoPlugin.fetchAuthSession();
    return AmplifyResponseSessionModel(
      isSignedIn: authSession.isSignedIn,
      refreshToken: authSession.userPoolTokensResult.value.refreshToken,
      token: authSession.userPoolTokensResult.value.idToken.raw,
    );
  }

  @override
  Future<String> getToken() async {
    final cognitoPlugin = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
    final authSession = await cognitoPlugin.fetchAuthSession();
    return authSession.userPoolTokensResult.value.idToken.raw;
  }

  @override
  Future<AmplifyResponseSignInEntity> signIn(AmplifySignInDto request) async {
    final result = await Amplify.Auth.signIn(
      username: request.username,
      password: request.password,
    );
    return AmplifyResponseSignInModel(
      isSignedIn: result.isSignedIn,
      signInStep: result.nextStep.signInStep,
    );
  }

  @override
  Future<void> signOut() async => await Amplify.Auth.signOut(
        options: SignOutOptions(globalSignOut: Platform.isAndroid),
      );
}
