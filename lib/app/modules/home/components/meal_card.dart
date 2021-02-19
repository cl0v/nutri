import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/model/meal_model.dart';
import 'package:nutri/app/modules/home/models/meal_card_model.dart';
import 'package:nutri/app/routes/app_pages.dart';
import 'package:nutri/constants.dart';

class MealCard extends StatelessWidget {
  final MealCardModel mealCardModel;
  final VoidCallback onConfirmedPressed;
  final VoidCallback onSkippedPressed;
  final VoidCallback onChangePressed;

  const MealCard({
    this.mealCardModel,
    this.onConfirmedPressed,
    this.onSkippedPressed,
    this.onChangePressed,
  });
  @override
  Widget build(BuildContext context) {
    print(mealCardModel.mealCardState);
    return Container(
      margin: EdgeInsets.all(4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage(mealCardModel.mealModel.food.img),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: (mealCardModel.mealCardState == MealCardState.Done
                      ? Colors.greenAccent
                      : mealCardModel.mealCardState == MealCardState.Skiped
                          ? Colors.redAccent
                          : Colors.black)
                  .withOpacity(0.6),
              borderRadius: BorderRadius.circular(15),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            MealModel.getTranslatedMeal(
                                mealCardModel.mealModel.meal),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(
                              Icons.info,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              print('so pode ser brinks');
                            },
                          )
                        ],
                      ),
                      Text(
                        '   • ${mealCardModel.mealModel.food.title}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      MealCardButtons(
                        onConfirmedPressed: onConfirmedPressed,
                        onSkippedPressed: onSkippedPressed,
                        onChangePressed: onChangePressed,
                        onTapBlocked: (mealCardModel.mealCardState ==
                                MealCardState.Done ||
                            mealCardModel.mealCardState ==
                                MealCardState.Skiped),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MealCardButtons extends StatelessWidget {
  const MealCardButtons({
    Key key,
    @required this.onConfirmedPressed,
    @required this.onSkippedPressed,
    @required this.onChangePressed,
    this.onTapBlocked = false,
  }) : super(key: key);

  final VoidCallback onConfirmedPressed;
  final VoidCallback onSkippedPressed;
  final VoidCallback onChangePressed;
  final bool onTapBlocked;

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
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
            ),
            child: Expanded(
              child: RaisedButton(
                onPressed: onTapBlocked ? null : onSkippedPressed,
                child: Text('Passei'),
                // icon: Icon(Icons.clear,),
              ),
            ),
          ),
          ButtonTheme(
            height: 30,
            buttonColor: kGrayColor,
            child: Expanded(
              child: RaisedButton(
                onPressed: onTapBlocked
                    ? null
                    : () {
                        Get.toNamed(Routes.FOOD_SWIPE);
                      },
                child: Text('Trocar'),
                // icon: Icon(Icons.clear,),
              ),
            ),
          ),
          // IconButton(icon: Icon(Icons.replay_outlined),onPressed: (),),
          ButtonTheme(
            height: 30,
            buttonColor: kGreenColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Expanded(
              child: RaisedButton(
                onPressed: onTapBlocked ? null : onConfirmedPressed,
                child: Text('Concluído'),
                // icon: Icon(
                //   Icons.check,
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
