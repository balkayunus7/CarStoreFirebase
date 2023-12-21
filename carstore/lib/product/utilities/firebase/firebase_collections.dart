import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollections {
  version,
  cars,
  tag,
  recomanded,
  selected_cars,
  users;

  CollectionReference get reference =>
      FirebaseFirestore.instance.collection(name);
}
