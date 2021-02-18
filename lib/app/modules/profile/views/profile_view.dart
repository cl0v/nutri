import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nutri/app/modules/profile/controllers/profile_controller.dart';
import 'package:nutri/app/routes/app_pages.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Get.toNamed(Routes.HOME);
                }),
            Spacer(),
            IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  // Get.toNamed(Routes.PROFILE);
                }),
          ],
        ),
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
          SafeArea(
            minimum: EdgeInsets.all(16),
            child: ListView(
              children: [
                CircleAvatar(
                  backgroundColor: Color.fromRGBO(17, 25, 56, 1),
                  radius: 100,
                  child: Icon(
                    Icons.person,
                    size: 100,
                  ),
                ),
                // ...List.generate(
                //   // 10,
                //   controller.user.toMap().keys.length,
                //   (index) => Card(
                //     child: ListTile(
                //       dense: true,
                //       // leading: Center(
                //       //   widthFactor: 1,
                //       //   child: Icon(Icons.exit_to_app),
                //       // ),
                //       // title: Text(
                //       //     '${controller.user.toMap().keys.toList()[index].toUpperCase()}'),
                //       // subtitle: Text(
                //       //     '${controller.user.toMap().values.toList()[index]}'),
                //       // trailing: Icon(Icons.arrow_forward_ios),
                //     ),
                //   ),
                // ),
                Card(
                  child: ListTile(
                    // dense: true,
                    onTap: () {
                      
                    },
                    title: Text('Ajuda'),
                    trailing: Icon(Icons.help),
                  ),
                ),
                Card(
                  child: ListTile(
                    // dense: true,
                    onTap: () {
                    },
                    title: Text('Configurações'),
                    trailing: Icon(Icons.settings),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                    },
                    title: Text('Sair'),
                    trailing: Icon(Icons.exit_to_app_sharp),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
