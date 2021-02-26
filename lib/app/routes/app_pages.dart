import 'package:get/get.dart';

import 'package:nutri/app/modules/food_swipe/bindings/food_swipe_binding.dart';
import 'package:nutri/app/modules/food_swipe/views/food_swipe_view.dart';
import 'package:nutri/app/modules/home/bindings/home_binding.dart';
import 'package:nutri/app/modules/home/views/home_view.dart';
import 'package:nutri/app/modules/login/bindings/login_binding.dart';
import 'package:nutri/app/modules/login/views/login_view.dart';
import 'package:nutri/app/modules/payment/bindings/payment_binding.dart';
import 'package:nutri/app/modules/payment/views/payment_view.dart';
import 'package:nutri/app/modules/profile/bindings/profile_binding.dart';
import 'package:nutri/app/modules/profile/views/profile_view.dart';
import 'package:nutri/app/modules/questions/bindings/questions_binding.dart';
import 'package:nutri/app/modules/questions/views/questions_view.dart';
import 'package:nutri/app/modules/register/bindings/register_binding.dart';
import 'package:nutri/app/modules/register/views/register_view.dart';
import 'package:nutri/app/modules/splash/bindings/splash_binding.dart';
import 'package:nutri/app/modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.QUESTIONS,
      page: () => QuestionsView(),
      binding: QuestionsBinding(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.FOOD_SWIPE,
      page: () => FoodSwipeView(),
      binding: FoodSwipeBinding(),
    ),
    GetPage(
      name: Routes.PAYMENT,
      page: () => PaymentView(),
      binding: PaymentBinding(),
    ),
  ];
}
