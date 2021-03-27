import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:nutri/app/pages/register/controllers/register_controller.dart';
import 'package:nutri/app/repositories/firebase_auth_repository.dart';
import 'package:nutri/app/viewmodels/user_auth_viewmodel.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
      () => RegisterController(
        userAuthViewModel: UserAuthViewModel(
          auth: FirebaseAuthRepository(
            auth: FirebaseAuth.instance,
          ),
        ),
      ),
    );
  }
}
