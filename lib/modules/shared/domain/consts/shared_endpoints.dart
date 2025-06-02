class SharedEndpoints {
  static const login = 'api/users/login';
  //auth
  static const authLogin = '/auth/login';
  //user
  static String fetchUser = '/users/me';
  static String editUser(String id) => '/users/$id';
}
