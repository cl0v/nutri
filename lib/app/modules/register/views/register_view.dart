import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/components/widgets/global_text_field.dart';
import 'package:nutri/app/modules/register/controllers/register_controller.dart';
import 'package:nutri/constants.dart';

//TODO: Aceitar termos e condições;

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: controller.onCancelRegisterPressed,
            ),
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
            child: PageView(
              controller: controller.pageController,
              pageSnapping: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                //TODO: Remover esse carinha primeiro e só liberar na hora do pagamento
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
                          style: Get.theme!.textTheme.headline4!
                              .copyWith(color: Colors.black54),
                        ),
                        Divider(),
                        Spacer(),
                        GlobalTextField(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                          controller: controller.nameController,
                          hint: 'Nome completo',
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        GlobalTextField(
                          // autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                controller.isObscurePassword ? Icons.visibility : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: controller.onShowPasswordPressed,
                            ),
                            controller: controller.passwordController,
                            hint: 'Senha',
                          ),
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
                            // textTheme: Get.theme.buttonTheme.textTheme,
                            onPressed: controller.onContinuePressed,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                          style: Get.theme!.textTheme.headline4!
                              .copyWith(color: Colors.black54),
                        ),
                        Divider(),
                        Spacer(),
                        GlobalTextField(
                          keyboardType: TextInputType.number,
                          prefixIcon: Icon(
                            Icons.height,
                            color: Colors.grey,
                          ),
                          controller: controller.heightController,
                          hint: 'Altura',
                          suffix: Text('cm'),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        GlobalTextField(
                          keyboardType: TextInputType.number,
                          prefixIcon: Icon(
                            Icons.fitness_center,
                            color: Colors.grey,
                          ),
                          controller: controller.weightController,
                          hint: 'Peso',
                          suffix: Text('kg'),
                        ),
                        Obx(
                          () => CheckboxListTile(
                            
                            controlAffinity: ListTileControlAffinity.leading,
                            dense: true,
                            value: controller.thermIsChecked,
                            title: Text(
                              'Aceitar termos e condições.',  //TODO: Criar link de termos e condições
                              style: Get.textTheme!.bodyText2!.copyWith(color: Colors.grey),
                            ),
                            onChanged: controller.checkTerms,
                            // subtitle: Text('Aceitar termos e condições.'),
                          ),
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            child: Text('Confirmar'),
                            onPressed: () => controller.onConfirmPressed(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
