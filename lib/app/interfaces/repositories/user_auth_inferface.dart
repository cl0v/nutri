enum LoginState {
  Idle,
  Connected,
  Error,
}
enum RegisterState {
  Idle,
  Created,
  Error,
}

abstract class IUserAuth {
  Future<LoginState> signIn(String email, String password);
  Future<RegisterState> signUp(String email, String password);
  Future signOut();
  Future<String> getErrorMessage();
  Future<bool> isUserConnected();
}
