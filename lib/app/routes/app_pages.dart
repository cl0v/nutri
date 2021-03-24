import 'package:get/get.dart';

import 'package:nutri/app/pages/faq/bindings/faq_binding.dart';
import 'package:nutri/app/pages/faq/views/faq_view.dart';
import 'package:nutri/app/pages/food_swipe/bindings/food_swipe_binding.dart';
import 'package:nutri/app/pages/food_swipe/views/food_swipe_view.dart';
import 'package:nutri/app/pages/home/bindings/home_binding.dart';
import 'package:nutri/app/pages/home/home_page.dart';
import 'package:nutri/app/pages/login/bindings/login_binding.dart';
import 'package:nutri/app/pages/login/views/login_view.dart';
import 'package:nutri/app/pages/profile/bindings/profile_binding.dart';
import 'package:nutri/app/pages/profile/views/profile_view.dart';
import 'package:nutri/app/pages/questions/bindings/questions_binding.dart';
import 'package:nutri/app/pages/questions/views/questions_view.dart';
import 'package:nutri/app/pages/register/bindings/register_binding.dart';
import 'package:nutri/app/pages/register/views/register_view.dart';
import 'package:nutri/app/pages/splash/bindings/splash_binding.dart';
import 'package:nutri/app/pages/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
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
      name: Routes.FAQ,
      page: () => FaqView(),
      binding: FaqBinding(),
    ),
  ];
}
