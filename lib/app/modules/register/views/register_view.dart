import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/modules/register/controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color.fromRGBO(242, 196, 117, 1), Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
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
                  'Criar conta',
                  style: Get.theme.textTheme.headline4,
                ),
                Text(
                  'POR FAVOR PREENCHA OS CAMPOS',
                  style: Get.theme.textTheme.subtitle1,
                ),
              ],
            ),
          ),
          SafeArea(
            minimum: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Center(
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: 'Nome completo',
                      labelText: 'Nome completo',
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(99),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
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
                      hintText: 'Senha',
                      labelText: 'Senha',
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(99),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 38,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: RaisedButton.icon(
                      label: Text('Continuar'),
                      icon: Icon(
                        Icons.arrow_forward,
                        size: 18,
                      ),
                      textTheme: Get.theme.buttonTheme.textTheme,
                      // textColor: Colors.white,
                      // color: Color.fromRGBO(244, 208, 120, 1),
                      onPressed: controller.onContinuePressed,
                      // shape: new RoundedRectangleBorder(
                      //   borderRadius: new BorderRadius.circular(9.0),
                      // ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
