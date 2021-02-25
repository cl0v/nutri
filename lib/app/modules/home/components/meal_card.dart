import 'package:flutter/material.dart';
import 'package:nutri/app/data/model/meal_model.dart';
import 'package:nutri/app/modules/home/models/meal_card_model.dart';
import 'package:nutri/constants.dart';

class MealCard extends StatelessWidget {
  final MealCardModel mealCardModel;
  final MealCardState mealCardState;
  final VoidCallback onConfirmedPressed;
  final VoidCallback onSkippedPressed;

  const MealCard({
    this.mealCardModel,
    this.mealCardState,
    this.onConfirmedPressed,
    this.onSkippedPressed,
  });
  @override
  Widget build(BuildContext context) {
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
              color: mealCardModel.mealCardState == MealCardState.Done
                  ? kGreenColor.withOpacity(0.6)
                  : mealCardModel.mealCardState == MealCardState.Skiped
                      ? kRedColor.withOpacity(0.6)
                      : null,
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
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${MealModel.getTranslatedMeal(mealCardModel.mealModel.mealType)} de hoje',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
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

// Align(
//   child: DotsIndicator(),
//   alignment: Alignment.centerRight,
// ),
// Trabalhar nos dots
class DotsIndicator extends StatelessWidget {
  DotsIndicator();

  Widget _buildDot(int index) {
    return Container(
      height: 12.0,
      margin: EdgeInsets.only(right: 16),
      child: Material(
        color: Colors.white,
        type: MaterialType.circle,
        child: Container(
          width: 8,
          height: 8,
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List<Widget>.generate(3, _buildDot),
    );
  }
}

class MealCardButtons extends StatelessWidget {
  const MealCardButtons({
    Key key,
    @required this.onConfirmedPressed,
    @required this.onSkippedPressed,
    this.onTapBlocked = false,
  }) : super(key: key);

  final VoidCallback onConfirmedPressed;
  final VoidCallback onSkippedPressed;
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
                child: Text('Pulei'),
                // icon: Icon(Icons.clear,),
              ),
            ),
          ),
          // ButtonTheme(
          //   height: 30,
          //   buttonColor: kGrayColor,
          //   child: Expanded(
          //     child: RaisedButton(
          //       onPressed: onTapBlocked
          //           ? null
          //           : () {
          //               Get.toNamed(Routes.FOOD_SWIPE);
          //             },
          //       child: Text('Trocar'),
          //       // icon: Icon(Icons.clear,),
          //     ),
          //   ),
          // ),
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
                child: Text('Concluí'),
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
