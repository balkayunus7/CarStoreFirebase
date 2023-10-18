import 'package:carstore/product/models/cars.dart';
import 'package:carstore/product/utilities/firebase/firebase_collections.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier() : super(const HomeState());

  Future<void> fetchCars() async {
    final carsCollectionReference = FirebaseCollections.cars.reference;
    final response = await carsCollectionReference.withConverter(
      fromFirestore: (snapshot, options) {
        return Cars().fromFirebase(snapshot);
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    ).get();
    if (response.docs.isNotEmpty) {
      final values = response.docs.map((e) => e.data()).toList();
      state = state.copyWith(cars: values);
    }
  }

  Future<void> fetchAndLoad() async {
    state = state.copyWith(isloaing: true);
    await fetchCars();
    state = state.copyWith(isloaing: false);
  }
}

class HomeState extends Equatable {
  const HomeState({this.isLoading, this.cars});

  final List<Cars>? cars;
  final bool? isLoading;

  @override
  List<Object?> get props => [cars, isLoading];

  HomeState copyWith({
    List<Cars>? cars,
    bool? isloaing,
  }) {
    return HomeState(
      cars: cars ?? this.cars,
      isLoading: isLoading ?? isLoading,
    );
  }
}
