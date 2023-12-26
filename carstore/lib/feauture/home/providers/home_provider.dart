import 'package:carstore/product/models/cars.dart';
import 'package:carstore/product/models/recomanded.dart';
import 'package:carstore/product/models/tag.dart';
import 'package:carstore/product/utilities/firebase/firebase_collections.dart';
import 'package:carstore/product/utilities/firebase/firebase_utility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// HomeNotifier class extends StateNotifier and includes FirebaseUtility
class HomeNotifier extends StateNotifier<HomeState> with FirebaseUtility {
  HomeNotifier() : super(const HomeState());

  // List to hold all cars and saved cars
  List<Cars> fullCarList = [];
  List<Cars> savedCarsList = [];

  // Function to get saved cars from Firebase
  Future<void> getSavedCars() async {
    // Get current user
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userUid = user.uid;
      final userDocument =
          FirebaseFirestore.instance.collection(FirebaseCollections.users.name).doc(userUid);

      // Get selected cars collection from user's document
      final selectedCarsCollection = userDocument.collection(FirebaseCollections.selected_cars.name);

      // Get snapshot of selected cars collection
      final QuerySnapshot querySnapshot = await selectedCarsCollection.get();

      // If there are documents in the snapshot
      if (querySnapshot.docs.isNotEmpty) {
        // Map each document to a Cars object and add to a list
        final List<Cars> item = querySnapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Cars().fromJson(data);
        }).toList();

        state = state.copyWith(cars: item);
        savedCarsList = item;
      } else {
        return;
      }
    } else {
      return;
    }
  }

  // Function to save selected car to Firebase
  Future<void> saveSelectedCar(Cars selectedCar) async {
    // Get current user
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userUid = user.uid;
      final userDocument =
          FirebaseFirestore.instance.collection(FirebaseCollections.users.name).doc(userUid);

      // Get selected cars collection from user's document
      final selectedCarsCollection = userDocument.collection(FirebaseCollections.selected_cars.name);
      // Check if car already exists in collection
      final querySnapshot = await selectedCarsCollection
          .where('id', isEqualTo: selectedCar.id)
          .get();

      // If car does not exist, add it to collection
      if (querySnapshot.docs.isEmpty) {
        await selectedCarsCollection.add(selectedCar.toJson());
      }
    }
  }

  // Function to fetch all cars from Firebase
  Future<void> fetchCars() async {
    final item = await fetchList<Cars, Cars>(Cars(), FirebaseCollections.cars);
    state = state.copyWith(cars: item);
    fullCarList = item ?? [];
  }

  // Function to fetch all tags from Firebase
  Future<void> fetchTags() async {
    final item = await fetchList<Tag, Tag>(Tag(), FirebaseCollections.tag);
    state = state.copyWith(tag: item);
  }

  // Function to fetch all recommended cars from Firebase
  Future<void> fetchRecommanded() async {
    final item = await fetchList<Recommended, Recommended>(
      Recommended(),
      FirebaseCollections.recomanded,
    );
    state = state.copyWith(recommended: item);
  }

  // Function to fetch all data and update state
  Future<void> fetchAndLoad() async {
    state = state.copyWith(isLoading: true);
    await Future.wait([
      fetchCars(),
      fetchTags(),
      fetchRecommanded(),
    ]);
    state = state.copyWith(isLoading: false);
  }
}

// HomeState class extends Equatable
class HomeState extends Equatable {
  const HomeState(
      {this.isLoading,
      this.selectedCars,
      this.recommended,
      this.tag,
      this.cars});

  final List<Cars>? cars;
  final List<Tag>? tag;
  final List<Recommended>? recommended;
  final List<Cars>? selectedCars;
  final bool? isLoading;

  // Override props for Equatable
  @override
  List<Object?> get props => [
        cars,
        tag,
        isLoading,
        recommended,
        selectedCars,
      ];

  // Function to copy HomeState with new values
  HomeState copyWith({
    List<Cars>? cars,
    bool? isLoading,
    List<Tag>? tag,
    List<Recommended>? recommended,
    List<Cars>? selectedCars,
  }) {
    return HomeState(
      cars: cars ?? this.cars,
      recommended: recommended ?? this.recommended,
      isLoading: isLoading ?? this.isLoading,
      tag: tag ?? this.tag,
      selectedCars: selectedCars ?? this.selectedCars,
    );
  }
}