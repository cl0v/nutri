import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/pages/splash/controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        Center(
          child: Image.asset('assets/launcher/icon.png')
        ),
    
    );
  }
}
