import 'package:get/get.dart';
import 'package:nutri/app/routes/app_pages.dart';
import 'package:nutri/app/viewmodels/user_auth_viewmodel.dart';

class SplashController extends GetxController {

  SplashController({
    required this.userAuthViewModel,
  });

  final UserAuthViewModel userAuthViewModel;


  @override
  void onInit() {
    super.onInit();
    init();
  }

  init() async {
    var userConnected = await userAuthViewModel.isUserConnected();
    if (userConnected) Get.offAllNamed(Routes.HOME);
    else Get.offAllNamed(Routes.LOGIN);
  }

}
