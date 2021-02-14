import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/modules/register/controllers/register_controller.dart';
import 'package:nutri/constants.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
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
                      'Criar conta',
                      style: Get.theme.textTheme.headline4,
                    ),
                    Divider(),
                    Spacer(),
                    TextFormField(
                      controller: controller.nameController,
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
                      height: 16,
                    ),
                    TextFormField(
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
                    Spacer(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: RaisedButton.icon(
                        label: Text('Continuar'),
                        icon: Icon(
                          Icons.arrow_forward,
                          size: 18,
                        ),
                        textTheme: Get.theme.buttonTheme.textTheme,
                        onPressed: controller.onContinuePressed,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          // ),
        ],
      ),
    );
  }
}
