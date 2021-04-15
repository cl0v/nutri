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
  Future<String> getErrorMessage();
  Future<RegisterState> signUp(String email, String password);
  Future<bool> isUserConnected();
  Future signOut();
}
