import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollections {
  version,
  cars,
  tag,
  recomanded;

  CollectionReference get reference =>
      FirebaseFirestore.instance.collection(name);
}
