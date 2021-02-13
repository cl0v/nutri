import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/modules/login/controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Image.asset(
          //   'assets/Profile.jpg',
          //   fit: BoxFit.fill,
          // ),
          ListView(
            children: [
              Container(
                // decoration: BoxDecoration(
                //   gradient: LinearGradient(
                //     colors: [Color.fromRGBO(242, 196, 117, 1), Colors.white],
                //     begin: Alignment.topCenter,
                //     end: Alignment.bottomCenter,
                //   ),
                // ),
                height: 240,
                padding: EdgeInsets.all(48),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 32,
                    ),
                    Text(
                      'Olá',
                      style: Get.theme.textTheme.headline4,
                    ),
                    Text(
                      'BEM VINDO DE VOLTA',
                      style: Get.theme.textTheme.subtitle1,
                    ),
                  ],
                ),
              ),
              SafeArea(
                minimum: EdgeInsets.all(32),
                child: Center(
                  child: Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: 'E-mail',
                          labelText: 'E-mail',
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(99),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 32),
                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: Icon(Icons.remove_red_eye),
                          hintText: 'Password',
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(99),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Align(
                        child: FlatButton(
                          onPressed: controller.onForgetPasswordPressed,
                          child: Text(
                            'Esqueceu sua senha?',
                            style: TextStyle(
                              color: Color.fromRGBO(248, 225, 185, 1),
                            ),
                          ),
                        ),
                        alignment: Alignment(0.9, 0),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      FlatButton(
                        onPressed: controller.onEnterPressed,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Entrar',
                              style: TextStyle(
                                fontSize: 32,
                              ),
                            ),
                            Icon(
                              Icons.check,
                              size: 32,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Ainda não tem conta? '),
                          ButtonTheme(
                            padding: EdgeInsets.zero,
                            minWidth: 0,
                            child: FlatButton(
                              padding: EdgeInsets.zero,
                              onPressed: controller.onCreateAccountPressed,
                              child: Text(
                                'Criar',
                                style: TextStyle(
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                        ],
                      )
                    
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
