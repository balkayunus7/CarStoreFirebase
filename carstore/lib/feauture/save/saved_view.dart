import 'package:carstore/feauture/home/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SavedPage extends ConsumerStatefulWidget {
  const SavedPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SavedPageState();
}

class _SavedPageState extends ConsumerState<SavedPage> {
  final _homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
    return HomeNotifier();
  });
  @override
  Widget build(BuildContext context) {
    final cars = ref.read(_homeProvider).selectedCars ?? [];

    return ListView.builder(
      itemCount: cars.length,
      itemBuilder: (context, index) {
        return Card(
            child: ListTile(
          title: Text(
            cars[index].title ?? '',
          ),
          subtitle: Text(
            cars[index].price ?? '',
          ),
        ));
      },
    );
  }
}
