import 'package:flutter/material.dart';

import 'package:nutri/app/modules/home/views/home_body.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            
            IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
              //TODO: implement previewDay
            },),
            Text('HOJE'),
            IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: (){
              //TODO: implement nextDay
            },),
          ],
        ),

        // TODO: Botao que vai para a checklist ???
        // TODO: Pagina de FAQ
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.help),
        //     onPressed: () {
              // TODO: implement FAQ PAGE
        //     },
        //   )
        // ],
      ),
      // bottomNavigationBar: BottomAppBar(child: Row(children: [IconButton(icon: Icon(Icons.home,), onPressed: (){},),],),),
      body: HomeBody(),
    );
  }
}
