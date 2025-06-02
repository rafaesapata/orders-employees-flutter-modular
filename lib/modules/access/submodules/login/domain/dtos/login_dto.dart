class LoginDTO {
  final String? email;
  final String? password;
  final String nextPageOnSuccessLogin;

  LoginDTO({
    this.email,
    this.password,
    required this.nextPageOnSuccessLogin,
  });

  Map<String, dynamic> get toJson => {
        'email': email,
        'password': password,
      };
}
