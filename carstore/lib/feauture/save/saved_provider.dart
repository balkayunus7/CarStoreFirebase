// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:carstore/product/models/cars.dart';

class SavedNotifier extends StateNotifier<SavedState> {
  SavedNotifier() : super(SavedState());

  List<Cars> savedCarsList = [];

  Future<void> getSavedCars() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userUid = user.uid;
      final userDocument =
          FirebaseFirestore.instance.collection('users').doc(userUid);
      final selectedCarsCollection = userDocument.collection('selected_cars');

      final QuerySnapshot querySnapshot = await selectedCarsCollection.get();

      if (querySnapshot.docs.isNotEmpty) {
        final List<Cars> item = querySnapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Cars().fromJson(data);
        }).toList();

        state = state.copyWith(selectedCars: item);
        savedCarsList = item;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<void> saveSelectedCar(Cars selectedCar) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userUid = user.uid;
      final userDocument =
          FirebaseFirestore.instance.collection('users').doc(userUid);

      final selectedCarsCollection = userDocument.collection('selected_cars');
      //*  same car can not be added to the list
      final querySnapshot = await selectedCarsCollection
          .where('id', isEqualTo: selectedCar.id)
          .get();

      if (querySnapshot.docs.isEmpty) {
        await selectedCarsCollection.add(selectedCar.toJson());
      }
    }
  }
}

class SavedState extends Equatable {
  SavedState({
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
