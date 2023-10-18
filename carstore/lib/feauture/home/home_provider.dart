import 'package:carstore/product/models/cars.dart';
import 'package:carstore/product/models/tag.dart';
import 'package:carstore/product/utilities/firebase/firebase_collections.dart';
import 'package:carstore/product/utilities/firebase/firebase_utility.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeNotifier extends StateNotifier<HomeState> with FirebaseUtility {
  HomeNotifier() : super(const HomeState());

  Future<void> fetchCars() async {
    final item = await fetchList<Cars, Cars>(Cars(), FirebaseCollections.cars);
    state = state.copyWith(cars: item);
  }

  Future<void> fetchTags() async {
    final item = await fetchList<Tag, Tag>(Tag(), FirebaseCollections.tag);
    state = state.copyWith(tag: item);
  }

  Future<void> fetchAndLoad() async {
    state = state.copyWith(isLoading: true);
    await fetchCars();
    await fetchTags();
    state = state.copyWith(isLoading: false);
  }
}

class HomeState extends Equatable {
  const HomeState({this.isLoading, this.tag, this.cars});

  final List<Cars>? cars;
  final List<Tag>? tag;

  final bool? isLoading;

  @override
  List<Object?> get props => [cars, tag, isLoading];

  HomeState copyWith({
    List<Cars>? cars,
    bool? isLoading,
    List<Tag>? tag,
  }) {
    return HomeState(
      cars: cars ?? this.cars,
      isLoading: isLoading ?? this.isLoading,
      tag: tag ?? this.tag,
    );
  }
}
