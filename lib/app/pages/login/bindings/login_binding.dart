import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:nutri/app/pages/login/controllers/login_controller.dart';
import 'package:nutri/app/repositories/firebase_auth_repository.dart';
import 'package:nutri/app/viewmodels/user_auth_viewmodel.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(
        userAuthViewModel: UserAuthViewModel(
          auth: FirebaseAuthRepository(
            auth: FirebaseAuth.instance,
          ),
        ),
      ),
    );
  }
}
