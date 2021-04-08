import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/pages/register/controllers/register_controller.dart';
import 'package:nutri/constants.dart';

//FIXME: Tamanho da tela não está respeitando todos os dispositivos(Testado no emulador)

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Theme(
        data: Get.theme!.copyWith(
          brightness: Brightness.light,
          hintColor: Colors.black54,
          unselectedWidgetColor: Colors.grey,
          textTheme: Get.textTheme!.copyWith(
            subtitle1:
                Get.textTheme!.subtitle1!.copyWith(color: Colors.black87),
          ),
        ),
        child: Center(
          child: Container(
            height: 450,
            margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            padding: EdgeInsets.all(kDefaultPadding),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: PageView(
              controller: controller.pageController,
              children: [
                Column(
                  children: [
                    Text(
                      'Criar conta',
                      style: Get.theme!.textTheme.headline4!
                          .copyWith(color: Colors.black54),
                    ),
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
                    SizedBox(
                      height: 16,
                    ),
                    Obx(
                      () => controller.registerError
                          ? Text(
                              controller.errorMsg,
                              style: TextStyle(
                                color: kErrorColor,
                              ), //Alterar para error text
                            )
                          : Container(),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        label: Text('Continuar'),
                        icon: Icon(
                          Icons.arrow_forward,
                          size: 18,
                        ),
                        onPressed: controller.onContinuePressed,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Criar conta',
                      style: Get.theme!.textTheme.headline4!
                          .copyWith(color: Colors.black54),
                    ),
                    Divider(),
                    Spacer(),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: controller.heightController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.height,
                        ),
                        hintText: 'Altura',
                        labelText: 'Altura',
                        suffix: Text('cm'),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: controller.weightController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.fitness_center,
                        ),
                        hintText: 'Peso',
                        labelText: 'Peso',
                        suffix: Text('kg'),
                      ),
                    ),
                    CheckboxListTile(
                      value: !controller.isMale,
                      onChanged: controller.toggleSex,
                      title: Text('Mulher'),
                    ),
                    CheckboxListTile(
                      value: controller.isMale,
                      onChanged: controller.toggleSex,
                      title: Text('Homem'),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        label: Text('Continuar'),
                        icon: Icon(
                          Icons.arrow_forward,
                          size: 18,
                        ),
                        onPressed: controller.onConfirmPressed,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
