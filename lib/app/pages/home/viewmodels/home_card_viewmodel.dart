import 'package:nutri/app/pages/home/models/home_card_model.dart';

abstract class IHomeCardBloc {
  Future<List<HomeCardModel>> fetchHomeCardList();
  Future saveHomeCard(HomeCardModel homeCard);
}

class HomeCardViewModel implements IHomeCardBloc {
  @override
  Future<List<HomeCardModel>> fetchHomeCardList() {
    //TODO: Implement home
    return Future.value([]);
  }

  @override
  Future saveHomeCard(HomeCardModel homeCard) async{
  }
}
