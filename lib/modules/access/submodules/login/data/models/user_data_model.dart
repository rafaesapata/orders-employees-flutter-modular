import '../../domain/entities/user_data_entity.dart';

class UserDataModel extends UserDataEntity {
  UserDataModel({
    super.password,
    super.email,
    super.message,
    super.accessToken,
    super.expiresIn,
    super.idToken,
    super.refreshToken,
    super.tokenType,
  });

  UserDataModel.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    email = json['email'];
    accessToken = json['AccessToken'];
    expiresIn = json['ExpiresIn'];
    idToken = json['IdToken'];
    refreshToken = json['RefreshToken'];
    tokenType = json['TokenType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['AccessToken'] = accessToken;
    data['ExpiresIn'] = expiresIn;
    data['IdToken'] = idToken;
    data['RefreshToken'] = refreshToken;
    data['TokenType'] = tokenType;
    return data;
  }

  factory UserDataModel.fromEntity(UserDataEntity entity) {
    return UserDataModel(
        accessToken: entity.accessToken,
        email: entity.email,
        expiresIn: entity.expiresIn,
        idToken: entity.idToken,
        message: entity.message,
        password: entity.password,
        refreshToken: entity.refreshToken,
        tokenType: entity.tokenType);
  }
}
