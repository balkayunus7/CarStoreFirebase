import 'package:carstore/product/utilities/exception/custom_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

mixin IDModel {
  String? id;
}

mixin BaseFirebaseModel<T> implements IDModel {
  T fromJson(Map<String, dynamic> json);
  T fromFirebase(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final value = snapshot.data();
    if (value == null) {
      throw CustomFirebaseException('$snapshot is null');
    }
    value.addAll({'id': snapshot.id});
    return fromJson(value);
  }
}
