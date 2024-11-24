abstract class LoginRepository {
  Future<dynamic> loginUser(
    String usernameOrEmail,
    String password,
    Function(dynamic) onSuccess,
    Function(String) onError,
  );

  Future<dynamic> getUserData(String email);
}
// Future<void> checkAuthState();
