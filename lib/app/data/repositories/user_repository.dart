import 'package:meta/meta.dart';
import 'package:nutri/app/data/providers/user_provider.dart';

class UserRepository {
  final UserProvider provider;

  UserRepository({@required this.provider}) : assert(provider != null);

  signin(String email, String password) => provider.signin(email, password);
  
  register(String email, String password) => provider.register(email, password);
}
