import 'package:get/get.dart';
import 'package:nutri/app/interfaces/repositories/user_auth_inferface.dart';
import 'package:nutri/app/routes/app_pages.dart';

class SplashController extends GetxController {

  SplashController({
    required this.auth,
  });


  final IUserAuth auth;


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async{
    super.onReady();
  //TODO: Descomentar tudo
    //  var userConnected = await auth.isUserConnected();
    // if (userConnected) Get.offAllNamed(Routes.HOME);
    // else Get.offAllNamed(Routes.LOGIN);
    Get.offAllNamed(Routes.HOME);
  }




}
