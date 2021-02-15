

import 'package:meta/meta.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/providers/food_provider.dart';

class FoodRepository {

final FoodProvider provider;

FoodRepository({@required this.provider});

Future<List<FoodModel>> loadFoodList() => provider.loadFoodList();

// getAll(){
//   return apiClient.getAll();
// }
// getId(id){
//   return apiClient.getId(id);
// }
// delete(id){
//   return apiClient.delete(id);
// }
// edit(obj){
//   return apiClient.edit( obj );
// }
// add(obj){
//     return apiClient.add( obj );
// }

}