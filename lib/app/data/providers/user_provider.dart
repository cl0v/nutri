import 'dart:async';

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

  // ignore: close_sinks
  StreamController<UserConnectionState> userConnectionState =
      StreamController();

  Stream<UserConnectionState> get userConnectionStateOutput =>
      userConnectionState.stream;

  Sink<UserConnectionState> get userConnectionStateInput =>
      userConnectionState.sink;

  Stream<UserConnectionState> getUserConnectionState() {
    _getUser();
    return userConnectionStateOutput;
  }

  UserLoginErrorState _userLoginErrorState =
      UserLoginErrorState.None; //Se eu precisar do estado
  String _loginErrorMsg = '';
  String _registerErrorMsg = '';

  String getUserLoginError() => _loginErrorMsg;
  String getUserRegisterError() => _registerErrorMsg;

  _getUser() {
    var user = auth.currentUser;
    if (user == null)
      userConnectionStateInput.add(UserConnectionState.Disconected);
    else
      userConnectionStateInput.add(UserConnectionState.Connected);
  }

  signin(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      userConnectionStateInput.add(UserConnectionState.Connected);
      userConnectionState.close();
    } on FirebaseAuthException catch (e) {
      userConnectionStateInput.add(UserConnectionState.Error);
      switch (e.code) {
        case 'user-not-found':
          _loginErrorMsg = 'Email não encontrado';
          break;
        case 'wrong-password':
          _loginErrorMsg = 'Senha incorreta';
          break;
        case 'invalid-email':
          _loginErrorMsg = 'Email inválido';
          break;
        case 'user-disabled':
          _loginErrorMsg = 'Usuário desativado';
          break;
        default:
          _loginErrorMsg = 'Verifique se os dados preenchidos estão corretos';
          return;
      }
    }
    userConnectionStateInput.add(UserConnectionState.Idle);
    //TODO: Provavelmente nao vale a pena
  }

  register(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      userConnectionStateInput.add(UserConnectionState.Connected);
      userConnectionState.close();
    } on FirebaseAuthException catch (e) {
      userConnectionStateInput.add(UserConnectionState.Error);
      switch (e.code) {
        case 'email-already-in-use':
          _registerErrorMsg = 'Email já está em uso';
          break;
        case 'invalid-email':
          _registerErrorMsg = 'Email inválido';
          break;
        case 'operation-not-allowed':
          _registerErrorMsg = 'Operação não permitida';
          break;
        case 'weak-password':
          _registerErrorMsg = 'Senha muito fraca (8 digitos)';
          break;
        default:
          _registerErrorMsg = 'Ocorreu um erro';
          return;
      }
      userConnectionStateInput.add(UserConnectionState.Idle);
    }
  }
}
