import 'package:nutri/app/models/diet_model.dart';

//TODO: Salvar os dados do menuCard para poder voltar e analisar
class MenuCardModel extends DietModel {
  late int selectedFoodIndex; //TODO: Decidir se isso pode ou nao ser nulo
  late List<int> selectedExtrasIndex;

  MenuCardModel({
    required DietModel diet,
    this.selectedFoodIndex = 0,
    this.selectedExtrasIndex = const [],
  }) : super(
          meal: diet.meal,
          extraFoodList: diet.extraFoodList,
          mainFoodList: diet.mainFoodList,
        );
}
