import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/data/model/extra_model.dart';
import 'package:nutri/app/data/providers/extra_provider.dart';
import 'package:nutri/app/data/repositories/extra_repository.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  ExtraRepository repository = ExtraRepository(provider: ExtraProvider());

  test('repository first element test', () async {
    List list = await repository.loadExtras();
    expect(list.first.title, ex1.title);
    expect(list.first.img, ex1.img);
    expect(list.first.desc, ex1.desc);
  });

}

ExtraModel ex1 = ExtraModel(
  title: "Brócolis",
  img: "assets/images/foods/brócolis.jpg",
  desc: "Brócolis é ótimo para sua saúde.",
);

ExtraModel ex2 = ExtraModel(
    title: "Alface",
    img: "assets/images/foods/alface.jpg",
    desc:
        "Folhas de alface são as alternativas muito saudáveis para seu prato.");

ExtraModel ex3 = ExtraModel(
    title: "Espinafre",
    img: "assets/images/foods/espinafre.jpg",
    desc:
        "Folhas de espinafre são as alternativas muito saudáveis para seu prato.");
