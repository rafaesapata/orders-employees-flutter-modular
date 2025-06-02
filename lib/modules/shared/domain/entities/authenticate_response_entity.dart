import 'user_entity.dart';

abstract class AuthenticateResponseEntity {
  final String? token;
  final String? expirationDate;
  final UserEntity? user;

  const AuthenticateResponseEntity({
    this.token,
    this.expirationDate,
    this.user,
  });

  Map<String, dynamic> toMap();
  String toJson();
}
