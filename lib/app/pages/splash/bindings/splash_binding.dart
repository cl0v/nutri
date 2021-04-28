import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:nutri/app/pages/splash/controllers/splash_controller.dart';
import 'package:nutri/app/repositories/firebase/firebase_auth_repository.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(
      SplashController(
        auth: FirebaseAuthRepository(
          auth: FirebaseAuth.instance,
        ),
      ),
    );
  }
}
