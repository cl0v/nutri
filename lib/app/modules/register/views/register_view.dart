import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/modules/register/controllers/register_controller.dart';
import 'package:nutri/constants.dart';

//TODO: Aceitar termos e condições;

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(
            'assets/Profile.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: PageView(
            controller: controller.pageController,
            pageSnapping: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
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
                          if (!GetUtils.isEmail(s))
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
                        obscureText: true,
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
                        style: Get.theme.textTheme.headline4,
                      ),
                      Divider(),
                      Spacer(),
                      TextFormField(
                        controller: controller.heightController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.height),
                          hintText: 'Altura',
                          labelText: 'Altura',
                          suffix: Text('cm'),
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
                        controller: controller.weightController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.fitness_center), //icons.speed
                          hintText: 'Peso',
                          labelText: 'Peso',
                          suffix: Text('kg'),
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(99),
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () => CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          dense: true,
                          value: controller.thermIsChecked,
                          title: Text(
                            'Aceitar termos e condições.',
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
                          // textTheme: Get.theme.buttonTheme.textTheme,
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
      ],
    );
  }
}
