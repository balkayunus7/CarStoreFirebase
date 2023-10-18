import 'package:carstore/product/utilities/base/base_firebase_model.dart';
import 'package:carstore/product/utilities/firebase/firebase_collections.dart';

mixin FirebaseUtility {
  Future<List<T>?> fetchList<T extends IDModel, R extends BaseFirebaseModel<T>>(
    R data,
    FirebaseCollections collections,
  ) async {
    final collectionReference = collections.reference;
    final response = await collectionReference.withConverter<T>(
      fromFirestore: (snapshot, options) {
        return data.fromFirebase(snapshot);
      },
      toFirestore: (value, options) {
        return {};
      },
    ).get();

    if (response.docs.isNotEmpty) {
      final values = response.docs.map((e) => e.data()).toList();
      return values;
    }
    return null;
  }
}
