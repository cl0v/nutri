import 'package:flutter/material.dart';

class MealCard extends StatelessWidget {
  final food;

  const MealCard({Key key, this.food}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              Image.network(food.img, fit: BoxFit.cover, width: 1000.0),
              Positioned(
                right: 0.0,
                top: 0.0,
                child: IconButton(
                  icon: Icon(
                    Icons.info,
                    size: 32,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    print('tapado');
                  },
                ),
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    '${food.prefs} : ${food.title}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // ButtonBar(
              //   alignment: MainAxisAlignment.center,
              //   children: [
              //     new RaisedButton(
              //       child: new Text('Hello'),
              //       onPressed: null,
              //     ),
              //     IconButton(
              //         icon: Icon(Icons.add),
              //         onPressed: () {
              //           print('2');
              //         }),
              //     IconButton(
              //         icon: Icon(Icons.add),
              //         onPressed: () {
              //           print('3');
              //         }),
              //     new RaisedButton(
              //       child: new Text('Hi'),
              //       onPressed: null,
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
