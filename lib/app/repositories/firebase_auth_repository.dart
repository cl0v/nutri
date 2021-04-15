import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutri/app/interfaces/repositories/user_auth_inferface.dart';


class FirebaseAuthRepository implements IUserAuth {
  final FirebaseAuth auth;

  FirebaseAuthRepository({required this.auth});

  @override
  Future<bool> isUserConnected() async {
    return auth.currentUser != null;
  }

  String? errorMsg;

  @override
  Future<LoginState> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return LoginState.Connected;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          errorMsg = 'Email não encontrado';
          break;
        case 'wrong-password':
          errorMsg = 'Senha incorreta';
          break;
        case 'invalid-email':
          errorMsg = 'Email inválido';
          break;
        case 'user-disabled':
          errorMsg = 'Usuário desativado';
          break;
        default:
          errorMsg = 'Verifique se os dados preenchidos estão corretos';
      }
      return LoginState.Error;
    } catch (e) {
      return LoginState.Idle;
    }
  }

  @override
  Future signOut() async {
    await auth.signOut();
  }

  @override
  Future<RegisterState> signUp(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return RegisterState.Created;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          errorMsg = 'Email já está em uso';
          break;
        case 'invalid-email':
          errorMsg = 'Email inválido';
          break;
        case 'operation-not-allowed':
          errorMsg = 'Operação não permitida';
          break;
        case 'weak-password':
          errorMsg = 'Senha muito fraca (8 digitos)';
          break;
        default:
          errorMsg = 'Ocorreu um erro';
      }
      return RegisterState.Error;
    } catch (e) {
      return RegisterState.Idle;
    }
  }

  @override
  Future<String> getErrorMessage() async {
    return errorMsg!;
  }
}
