import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/routes/app_pages.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () => Get.offAllNamed(Routes.LOGIN));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        'assets/Profile.jpg',
        fit: BoxFit.fill,
      ),
      Container(
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 200, bottom: 10),
            child: Container(
              height: 200,
              width: 200,
            ),
          ),
          Text(
            'CONNECT',
            style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 20,
                decoration: TextDecoration.none),
          ),
        ]),
      ),
    ]);
  }
}
