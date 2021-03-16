import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/modules/splash/controllers/splash_controller.dart';

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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(300),
            child: Container(
              height: 200,
              width: 300,
              color: Colors.black26,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  
                      Text(
                        'H&L',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 64,
                          decoration: TextDecoration.none,
                        ),
                      ),
                  Text(
                    'Saúde e Vida',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  SizedBox(height: 32,),
                  Container(child: LinearProgressIndicator(), width: 100,)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
