import 'dart:convert';

import '../../domain/entities/authenticate_response_entity.dart';
import 'user_model.dart';

class AuthenticateResponseModel extends AuthenticateResponseEntity {
  AuthenticateResponseModel({
    required super.token,
    required super.expirationDate,
    required super.user,
  });

  factory AuthenticateResponseModel.fromJson(Map<String, dynamic> json) =>
      AuthenticateResponseModel(
        token: json['token'],
        expirationDate: json['expirationDate'],
        user: UserModel.fromMap(json['user']),
      );

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        'token': token,
        'expirationDate': expirationDate,
        'user': user?.toMap(),
      };
}
