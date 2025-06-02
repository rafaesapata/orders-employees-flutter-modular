import 'dart:convert';

import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    String? fullName,
    String? maskedDocumentNumber,
    String? birthdate,
    bool? photoUrl,
    bool? userName,
    String? email,
    String? cellPhone,
    String? passwordUpdatedDate,
    num? passwordErrorsAllowed,
    String? id,
    bool? isActive,
    String? createDate,
  });

  factory UserModel.fromJson(String json) =>
      UserModel.fromMap(jsonDecode(json));

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        fullName: map['fullName'],
        maskedDocumentNumber: map['maskedDocumentNumber'],
        birthdate: map['birthdate'],
        photoUrl: map['photoUrl'],
        userName: map['userName'],
        email: map['email'],
        cellPhone: map['cellPhone'],
        passwordUpdatedDate: map['passwordUpdatedDate'],
        passwordErrorsAllowed: map['passwordErrorsAllowed'],
        id: map['id'],
        isActive: map['isActive'],
        createDate: map['createDate'],
      );

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        'fullName': fullName,
        'maskedDocumentNumber': maskedDocumentNumber,
        'birthdate': birthdate,
        'photoUrl': photoUrl,
        'userName': userName,
        'email': email,
        'cellPhone': cellPhone,
        'passwordUpdatedDate': passwordUpdatedDate,
        'passwordErrorsAllowed': passwordErrorsAllowed,
        'id': id,
        'isActive': isActive,
        'createDate': createDate,
      };
}
