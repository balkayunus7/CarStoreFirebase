import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollections {
  version,
  cars,
  tag,
  recomanded,
  // ignore: constant_identifier_names
  selected_cars,
  users;

  CollectionReference get reference =>
      FirebaseFirestore.instance.collection(name);
}
