import 'package:firebase_auth/firebase_auth.dart';

enum UserConnectionState {
  Disconected,
  Connected,
  Waiting,
  Error,
  Idle,
}

enum UserLoginErrorState {
  WrongPassword,
  UserNotFound,
  InvalidEmail,
  UserDisabled,
  UnknowError,
  None,
}

enum UserRegisterErrorState {
  OperationNotAllowed,
  EmailAlreadyInUse,
  WeakPassword,
  InvalidEmail,
  UnknowError,
  None,
}

class UserProvider {
  final FirebaseAuth auth;

  UserProvider({required this.auth});

  signin(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      UserLoginErrorState userErrorState = UserLoginErrorState.None;
      print(e.code);
      if (e.code == 'user-not-found') {
        userErrorState = UserLoginErrorState.UserNotFound;
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        userErrorState = UserLoginErrorState.WrongPassword;
        print('Wrong password provided for that user.');
      } else if (e.code == 'invalid-email') {
        userErrorState = UserLoginErrorState.InvalidEmail;
        print('Invalid email');
      } else if (e.code == 'user-disabled') {
        userErrorState = UserLoginErrorState.UserDisabled;
        print('User disabled.');
      } else {
        userErrorState = UserLoginErrorState.UnknowError;
      }
      return userErrorState;
    } catch (e) {
      print(e);
    }
  }

  register(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      UserRegisterErrorState userRegisterErrorState =
          UserRegisterErrorState.None;
      if (e.code == 'email-already-in-use') {
        userRegisterErrorState = UserRegisterErrorState.EmailAlreadyInUse;
        print('The password provided is too weak.');
      } else if (e.code == 'invalid-email') {
        userRegisterErrorState = UserRegisterErrorState.InvalidEmail;
        print('The account already exists for that email.');
      } else if (e.code == 'operation-not-allowed') {
        userRegisterErrorState = UserRegisterErrorState.OperationNotAllowed;
        print('The account already exists for that email.');
      } else if (e.code == 'weak-password') {
        userRegisterErrorState = UserRegisterErrorState.WeakPassword;
        print('The account already exists for that email.');
      } else {}
      return userRegisterErrorState;
    } catch (e) {
      print(e);
    }
  }
}
