import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nutri/app/modules/home/controllers/home_controller.dart';
import 'package:nutri/app/modules/home/views/body.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeBody(
        controller: controller,
      ),
    );
  }
}