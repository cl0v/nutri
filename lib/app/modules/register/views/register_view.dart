import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/modules/register/controllers/register_controller.dart';
import 'package:nutri/constants.dart';

//TODO: Aceitar termos e condições;

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    TextFormField(
                      controller: controller.nameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                        ),
                        hintText: 'Nome completo',
                        labelText: 'Nome completo',
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
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
                    Obx(
                      () => CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        dense: true,
                        value: controller.thermIsChecked,
                        title: Text(
                          'Aceitar termos e condições.',
                           //TODO: Criar link de termos e condições
                          // style: Get.textTheme!.bodyText2!
                          //     .copyWith(color: Colors.grey),
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
    );
  }
}
