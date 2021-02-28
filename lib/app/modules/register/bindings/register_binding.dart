import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/providers/user_provider.dart';
import 'package:nutri/app/data/repositories/user_repository.dart';
import 'package:nutri/app/modules/register/controllers/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
      () => RegisterController(
        repository: UserRepository(
          provider: UserProvider(
            auth: FirebaseAuth.instance,
          ),
        ),
      ),
    );
  }
}
