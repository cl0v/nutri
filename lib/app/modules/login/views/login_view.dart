import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/modules/login/controllers/login_controller.dart';
import 'package:nutri/constants.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              'assets/Profile.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // SafeArea(
          //   minimum: EdgeInsets.symmetric(vertical: 128),
            // child:
             Center(
              child: Container(
                height: 450,
                margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                padding: EdgeInsets.all(kDefaultPadding),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  children: [
                    Text(
                      'Bem-vindo',
                      style: Get.theme.textTheme.headline4,
                    ),
                    Divider(),
                    Spacer(),
                    // TextFormField(),
                    TextFormField(
                      // autofocus: true,
                      validator: (s) {
                        if (!GetUtils.isEmail(s)) return 'Email incorreto';
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
                      controller: controller.emailController,
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
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: controller.passwordController,
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
                    FlatButton(
                      onPressed: controller.onForgetPasswordPressed,
                      child: Text(
                        'Esqueceu sua senha?',
                        style: TextStyle(
                          color: Color.fromRGBO(248, 225, 185, 1),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: RaisedButton(
                        //TODO: Modificar o botao de login
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
            // ),
          ),
        ],
      ),
    );
  }
}
