import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollections {
  version,
  cars,
  tag;

  CollectionReference get reference =>
      FirebaseFirestore.instance.collection(name);
}
