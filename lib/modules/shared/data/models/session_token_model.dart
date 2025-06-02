import 'dart:convert';

import '../../domain/entities/session_token_entity.dart';

class SessionTokenModel extends SessionTokenEntity {
  SessionTokenModel({
    required super.token,
    required super.expirationDate,
  });

  factory SessionTokenModel.fromMap(
    Map<String, dynamic> map,
  ) =>
      SessionTokenModel(
        token: map['token'] as String,
        expirationDate: DateTime.parse(map['expirationDate']),
      );

  factory SessionTokenModel.fromJson(String source) =>
      SessionTokenModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        'token': token,
        'expirationDate': expirationDate.toString(),
      };

  @override
  String toJson() => json.encode(toMap());
}
