abstract class AmplifyResponseSessionEntity {
  bool isSignedIn;
  String? token;
  String? refreshToken;

  AmplifyResponseSessionEntity({
    required this.isSignedIn,
    required this.token,
    required this.refreshToken,
  });
}
