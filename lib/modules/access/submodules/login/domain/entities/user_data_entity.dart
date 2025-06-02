 class UserDataEntity {
  String? password;
  String? email;
  String? message;
  String? accessToken;
  int? expiresIn;
  String? idToken;
  String? refreshToken;
  String? tokenType;

  UserDataEntity({
    this.password,
    this.email,
    this.message,
    this.accessToken,
    this.expiresIn,
    this.idToken,
    this.refreshToken,
    this.tokenType,
  });
}
