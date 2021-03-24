import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/providers/user_provider.dart';
import 'package:nutri/app/data/repositories/user_repository.dart';
import 'package:nutri/app/pages/login/controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(
        repository: UserRepository(
          provider: UserProvider(
            auth: FirebaseAuth.instance,
          ),
        ),
      ),
    );
  }
}
