import 'package:nutri/app/pages/home/models/home_card_model.dart';

abstract class IHomeCardBloc {
  Future<List<HomeCardModel>> fetchHomeCardList();
  Future saveHomeCard(HomeCardModel homeCard); //Review
}

class HomeCardViewModel implements IHomeCardBloc {
  @override
  Future<List<HomeCardModel>> fetchHomeCardList() {
    //TODO: Implement home
    //Esse cara vai producrar no banco de dados quais ja tem, os que tiver ele completa com os que ainda nao tem
    
    return Future.value([]);
  }

  @override
  Future saveHomeCard(HomeCardModel homeCard) async{
  }
}
