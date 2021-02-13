import 'package:get/get.dart';
import 'package:nutri/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  onConfirmPressed() {}

  void onContinuePressed() {
    Get.offAllNamed(Routes.QUESTIONS);
  }
}
