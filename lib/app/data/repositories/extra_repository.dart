import 'package:flutter/foundation.dart';
import 'package:nutri/app/data/model/extra_model.dart';
import 'package:nutri/app/data/providers/extra_provider.dart';

class ExtraRepository {
  final ExtraProvider provider;

  ExtraRepository({@required this.provider});

  Future<List<ExtraModel>> loadExtras() => provider.loadExtras();

Future<List<ExtraModel>> sizedExtraList({int amount}) =>
      provider.sizedExtraList(amount);
}
