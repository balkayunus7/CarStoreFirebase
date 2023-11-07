abstract class BaseFirestoreService {
  Future addToFirestore(
      Map<String, dynamic> data, String collectionName, String docName);

  Future updateDataToFirestore(
      Map<String, dynamic> data, String collectionName, String docName);

  Future getUserDataFromFirestore(
      Map<String, dynamic> data, String collectionName, String docName);
}
