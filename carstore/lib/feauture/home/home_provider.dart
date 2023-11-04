import 'package:carstore/product/models/cars.dart';
import 'package:carstore/product/models/recomanded.dart';
import 'package:carstore/product/models/tag.dart';
import 'package:carstore/product/utilities/firebase/firebase_collections.dart';
import 'package:carstore/product/utilities/firebase/firebase_utility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeNotifier extends StateNotifier<HomeState> with FirebaseUtility {
  HomeNotifier() : super(const HomeState());

  List<Cars> fullCarList = [];
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

  Future<void> fetchCars() async {
    final item = await fetchList<Cars, Cars>(Cars(), FirebaseCollections.cars);
    state = state.copyWith(cars: item);
    fullCarList = item ?? [];
  }

  Future<void> fetchTags() async {
    final item = await fetchList<Tag, Tag>(Tag(), FirebaseCollections.tag);
    state = state.copyWith(tag: item);
  }

  Future<void> fetchRecommanded() async {
    final item = await fetchList<Recommended, Recommended>(
      Recommended(),
      FirebaseCollections.recomanded,
    );
    state = state.copyWith(recommended: item);
  }

  Future<void> fetchAndLoad() async {
    state = state.copyWith(isLoading: true);
    await Future.wait([fetchCars(), fetchTags(), fetchRecommanded()]);
    state = state.copyWith(isLoading: false);
  }
}

//* state notifier provider created to be used

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

  @override
  List<Object?> get props => [
        cars,
        tag,
        isLoading,
        recommended,
        selectedCars,
      ];

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
