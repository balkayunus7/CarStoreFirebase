import 'package:carstore/product/utilities/firebase/firebase_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:carstore/product/models/cars.dart';

class SavedNotifier extends StateNotifier<SavedState> {
  SavedNotifier() : super(const SavedState());

  List<Cars> savedCarsList = [];

  Future<void> getSavedCars() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userUid = user.uid;
      final userDocument =
          FirebaseFirestore.instance.collection(FirebaseCollections.users.name).doc(userUid);
      final selectedCarsCollection = userDocument.collection(FirebaseCollections.selected_cars.name);

      final QuerySnapshot querySnapshot = await selectedCarsCollection.get();

      if (querySnapshot.docs.isNotEmpty) {
        final List<Cars> item = querySnapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Cars().fromJson(data);
        }).toList();

        state = state.copyWith(selectedCars: item);
        savedCarsList = item;
      } else {
        return;
      }
    } else {
      return;
    }
  }

  Future<void> saveSelectedCar(Cars selectedCar) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userUid = user.uid;
      final userDocument =
          FirebaseFirestore.instance.collection(FirebaseCollections.users.name).doc(userUid);

      final selectedCarsCollection = userDocument.collection(FirebaseCollections.selected_cars.name);
      //*  same car can not be added to the list
      final querySnapshot = await selectedCarsCollection
          .where('id', isEqualTo: selectedCar.id)
          .get();

       if(querySnapshot.docs.isNotEmpty){
         await selectedCarsCollection.add(selectedCar.toJson());
       }
    }
  }

  Future<void> deleteSavedCar(Cars selectedCar) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userUid = user.uid;
      final userDocument =
          FirebaseFirestore.instance.collection(FirebaseCollections.users.name).doc(userUid);

      final selectedCarsCollection = userDocument.collection(FirebaseCollections.selected_cars.name);
      //*  same car can not be added to the list
      final querySnapshot = await selectedCarsCollection
          .where('id', isEqualTo: selectedCar.id)
          .get();

        if (querySnapshot.docs.isNotEmpty) {
      final docId = querySnapshot.docs.first.id;
      await selectedCarsCollection.doc(docId).delete();

      // Remove the deleted car from the local list
      savedCarsList.removeWhere((car) => car.id == selectedCar.id);

      // Update the state to trigger a rebuild
      state = state.copyWith(selectedCars: savedCarsList);
    }
    }
  }
}

class SavedState extends Equatable {
  const SavedState({
    this.selectedCars,
  });
  final List<Cars>? selectedCars;

  @override
  List<Object?> get props => [selectedCars];

  SavedState copyWith({
    List<Cars>? selectedCars,
  }) {
    return SavedState(
      selectedCars: selectedCars ?? this.selectedCars,
    );
  }
}
