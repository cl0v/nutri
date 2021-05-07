import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IServerStorage {
  create(String collectionPath, Map<String, dynamic> data);
  CollectionReference getCollection(String collectionPath,);
  update();
  delete();
}
