import 'package:get/get.dart';
import 'package:nutri/app/routes/app_pages.dart';

class LoginController extends GetxController {
  void onCreateAccountPressed() {
    Get.toNamed(Routes.REGISTER);
  }

  void onForgetPasswordPressed() {
  }

  void onEnterPressed() {
    Get.offAllNamed(Routes.HOME);
  }
}
