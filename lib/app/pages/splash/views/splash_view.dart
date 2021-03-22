import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/pages/splash/controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/Profile.jpg',
          fit: BoxFit.fill,
        ),
        Center(
          child: Image.asset('assets/launcher/logon.png')
        ),
      ],
    );
  }
}
