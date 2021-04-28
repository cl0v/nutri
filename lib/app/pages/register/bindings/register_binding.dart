import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:nutri/app/pages/register/controllers/register_controller.dart';
import 'package:nutri/app/repositories/firebase/firebase_auth_repository.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
      () => RegisterController(
        userAuth: FirebaseAuthRepository(
          auth: FirebaseAuth.instance,
        ),
      ),
    );
  }
}
