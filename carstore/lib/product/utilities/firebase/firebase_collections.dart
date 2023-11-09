import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollections {
  version,
  cars,
  tag,
  recomanded,
  users;

  CollectionReference get reference =>
      FirebaseFirestore.instance.collection(name);
}
