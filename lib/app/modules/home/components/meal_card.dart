import 'package:flutter/material.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/constants.dart';

// TODO: Criar botoes que quando a pessoa toca, remove a imagem da lista
class MealCard extends StatelessWidget {
  final Function onConfirmedPressed;
  final FoodModel food;

  //TODO: Modificar para meal(vai ter um componente food)
  /*
  MealModel(FoodModel food, String ou enum meal)
  */
  //TODO: Create animate to paint everything with white

  const MealCard({this.onConfirmedPressed, this.food});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(4.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(food.img), //Trocar por ASSETIMAGE
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 4,
                      right: 4,
                      bottom: 0,
                      top: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    //TODO: Adicionar botao de informacoes Icon.info
                    //TODO: Modificar os botoes concluido e 'passei'
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Café da manhã:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' • ${food.title}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        MealCardButtons(onConfirmedPressed: onConfirmedPressed),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: Icon(
              Icons.info,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}

class MealCardButtons extends StatelessWidget {
  const MealCardButtons({
    Key key,
    @required this.onConfirmedPressed,
  }) : super(key: key);

  final Function onConfirmedPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // buttonHeight: 30,
        // alignment: MainAxisAlignment.spaceBetween,
        children: [
          ButtonTheme(
            height: 30,
            buttonColor: kRedColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: RaisedButton(
              onPressed: () {},
              child: Text('Passei'),
              // icon: Icon(Icons.clear,),
            ),
          ),
          ButtonTheme(
            height: 30,
            buttonColor: kGrayColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: RaisedButton(
              onPressed: () {},
              child: Text('Trocar'),
              // icon: Icon(Icons.clear,),
            ),
          ),

          // IconButton(icon: Icon(Icons.replay_outlined),onPressed: (),),
          ButtonTheme(
            height: 30,
            buttonColor: kGreenColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: RaisedButton(
              onPressed: onConfirmedPressed,
              child: Text('Concluído'),
              // icon: Icon(
              //   Icons.check,
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
