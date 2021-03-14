import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/components/widgets/global_text_field.dart';
import 'package:nutri/app/modules/login/controllers/login_controller.dart';
import 'package:nutri/constants.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Container(
        //   height: double.infinity,
        //   width: double.infinity,
        //   child: Image.asset(
        //     'assets/Profile.jpg',
        //     fit: BoxFit.cover,
        //   ),
        // ),
        Scaffold(
          // backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              height: 450,
              margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              padding: EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                color: kBoxColor,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  Text(
                    'Bem-vindo',
                    style: Get.theme!.textTheme.headline4!
                        .copyWith(color: Colors.black),
                  ),
                  Divider(),
                  Spacer(),
                  GlobalTextField(
                    validator: (s) {
                      if (!GetUtils.isEmail(s!))
                        return 'Por favor insira um email valido';
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                    controller: controller.emailController,
                    hint: 'E-mail',
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Obx(
                    () => GlobalTextField(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.grey,
                      ),
                      obscureText: controller.isObscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: Colors.grey,
                        ),
                        onPressed: controller.onShowPasswordPressed,
                      ),
                      controller: controller.passwordController,
                      hint: 'Password',
                    ),
                  ),
                  Obx(
                    () => controller.loginError
                        ? Text(
                            controller.errorMsg,
                            style: TextStyle(color: kErrorColor),
                          )
                        : Container(),
                  ),
                  TextButton(
                    onPressed: controller.onForgetPasswordPressed,
                    child: Text(
                      'Esqueceu sua senha?',
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: controller.onEnterPressed,
                      child: Text(
                        'Entrar',
                        style: TextStyle(fontSize: 26),
                      ),
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Ainda não tem conta?',
                        style: Get.textTheme!.bodyText2!.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(alignment: Alignment.centerLeft, ),
                        onPressed: controller.onCreateAccountPressed,
                        child: Text(
                          'Criar',
                          style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
