import 'package:flutter/material.dart';

class CarrousselCard extends StatefulWidget {
  @override
  _CarrousselCardState createState() => _CarrousselCardState();
}

class _CarrousselCardState extends State<CarrousselCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child:
     PageView(
       pageSnapping: false,
      children: [
        Card(
          child: Container(
            width: 200,
            color: Colors.red,
          ),
        ),
        Card(
          child: Container(
            color: Colors.blue,
          ),
        ),
        Card(
          child: Container(
            color: Colors.yellow,
          ),
        )
      ],
    ),);
  }
}

class FoodCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/chicken.jpg"),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
            ),
          ),
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white.withOpacity(.1), Colors.black],
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              'TABOM PROCE?',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
