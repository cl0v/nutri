import 'package:get/get.dart';
import 'package:nutri/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  get nameController => null;

  get emailController => null;

  get passwordController => null;

  onConfirmPressed() {}

  void onContinuePressed() {
    Get.offAllNamed(Routes.QUESTIONS);
  }
}
