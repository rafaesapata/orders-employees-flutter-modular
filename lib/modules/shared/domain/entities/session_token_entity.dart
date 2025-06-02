abstract class SessionTokenEntity {
  final String token;
  final DateTime expirationDate;

  SessionTokenEntity({
    required this.token,
    required this.expirationDate,
  });

  Map<String, dynamic> toMap();

  String toJson();
}
