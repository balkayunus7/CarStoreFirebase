import 'package:carstore/product/models/cars.dart';
import 'package:carstore/product/models/recomanded.dart';
import 'package:carstore/product/models/tag.dart';
import 'package:carstore/product/utilities/firebase/firebase_collections.dart';
import 'package:carstore/product/utilities/firebase/firebase_utility.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeNotifier extends StateNotifier<HomeState> with FirebaseUtility {
  HomeNotifier() : super(const HomeState());

  List<Cars> fullCarList = [];

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
  const HomeState({this.isLoading, this.recommended, this.tag, this.cars});

  final List<Cars>? cars;
  final List<Tag>? tag;
  final List<Recommended>? recommended;

  final bool? isLoading;

  @override
  List<Object?> get props => [cars, tag, isLoading, recommended];

  HomeState copyWith({
    List<Cars>? cars,
    bool? isLoading,
    List<Tag>? tag,
    List<Recommended>? recommended,
  }) {
    return HomeState(
      cars: cars ?? this.cars,
      recommended: recommended ?? this.recommended,
      isLoading: isLoading ?? this.isLoading,
      tag: tag ?? this.tag,
    );
  }
}
