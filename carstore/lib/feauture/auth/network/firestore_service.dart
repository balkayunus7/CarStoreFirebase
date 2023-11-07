import 'package:carstore/feauture/auth/network/abstract/base_firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService extends BaseFirestoreService {
  final _firestoreInstance = FirebaseFirestore.instance;

  @override
  Future addToFirestore(
      Map<String, dynamic> data, String collectionName, String docName) async {
    try {
      await _firestoreInstance
          .collection(collectionName)
          .doc(docName)
          .set(data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future updateDataToFirestore(
      Map<String, dynamic> data, String collectionName, String docName) async {
    try {
      _firestoreInstance.collection(collectionName).doc(docName).update(data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future getUserDataFromFirestore(
      Map<String, dynamic> data, String collectionName, String docName) async {
    final userData =
        await _firestoreInstance.collection(collectionName).doc(docName).get();
    return userData.data();
  }
}
