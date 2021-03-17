import 'package:get/get.dart';
import 'package:nutri/app/data/providers/user_provider.dart';
import 'package:nutri/app/data/repositories/user_repository.dart';
import 'package:nutri/app/routes/app_pages.dart';

class SplashController extends GetxController {
  final UserRepository userRepository;

  SplashController({required this.userRepository});

  late Rx<UserConnectionState> userConnectionState =
      UserConnectionState.Idle.obs;

  @override
  void onInit() {
    super.onInit();
    ever(userConnectionState, onUserConnectionStateChange);
    userConnectionState.bindStream(userRepository.getUserConnectionState());
  }

  @override
  onClose() {
    super.onClose();
    userRepository.closeUserConnectionState();
  }

  onUserConnectionStateChange(state) {
    switch (state) {
      case UserConnectionState.Connected:
        Get.offAllNamed(Routes.HOME);
        break;
      case UserConnectionState.Disconected:
        Get.offAllNamed(Routes.LOGIN);
        break;
    }
  }
}
