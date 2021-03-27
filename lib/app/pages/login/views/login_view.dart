import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/pages/login/controllers/login_controller.dart';
import 'package:nutri/constants.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Theme(
            data: Get.theme!.copyWith(
              brightness: Brightness.light,
              hintColor: Colors.black54,
              textTheme: Get.textTheme!.copyWith(
                subtitle1:
                    Get.textTheme!.subtitle1!.copyWith(color: Colors.black87),
              ),
            ),
            child: Center(
              child: Container(
                height: 420,
                margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                padding: EdgeInsets.all(kDefaultPadding),
                decoration: BoxDecoration(
                  color: kBoxColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  children: [
                    Text('Bem-vindo',
                        style: Get.theme!.textTheme.headline4!
                            .copyWith(color: Colors.black54)),
                    Divider(),
                    Spacer(),
                    TextFormField(
                      validator: (s) {
                        if (!GetUtils.isEmail(s!))
                          return 'Por favor insira um email valido';
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
                      controller: controller.emailController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: 'E-mail',
                        labelText: 'E-mail',
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Obx(
                      () => TextFormField(
                        obscureText: controller.isObscurePassword,
                        controller: controller.passwordController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isObscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: controller.onShowPasswordPressed,
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                          ),
                          hintText: 'Senha',
                          labelText: 'Senha',
                        ),
                      ),
                    ),
                    Obx(
                      () => controller.loginError
                          ? Text(
                              controller.errorMsg,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: kErrorColor), //Alterar para error text
                            )
                          : Container(),
                    ),
                    SizedBox(height: 8,),

                    // TextButton(
                    //   onPressed: controller.onForgetPasswordPressed,
                    //   child: Text(
                    //     'Esqueceu sua senha?',
                    //   ),
                    // ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: controller.onLoginPressed,
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
                          style: ButtonStyle(
                            alignment: Alignment.centerLeft,
                          ),
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
        ),
      ],
    );
  }
}
