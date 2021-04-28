import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:nutri/app/pages/login/controllers/login_controller.dart';
import 'package:nutri/app/repositories/firebase/firebase_auth_repository.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(
        userAuth: FirebaseAuthRepository(
          auth: FirebaseAuth.instance,
        ),
      ),
    );
  }
}
