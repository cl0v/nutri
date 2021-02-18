import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nutri/app/modules/home/controllers/home_controller.dart';
import 'package:nutri/app/modules/home/views/body.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Comer hoje'),
        centerTitle: true,

        //TODO: Pagina de FAQ
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.help),
        //     onPressed: () {},
        //   )
        // ],
      ),
      // bottomNavigationBar: BottomAppBar(child: Row(children: [IconButton(icon: Icon(Icons.home,), onPressed: (){},),],),),
      body: HomeBody(),
    );
  }
}
