import 'package:carstore/feauture/item/selected_item_view.dart';
import 'package:carstore/product/models/cars.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class HomeSearchDelegate extends SearchDelegate<Cars?> {
  HomeSearchDelegate(
    this.carItems,
  );

  final List<Cars> carItems;
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new_outlined),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = carItems.where(
      (element) =>
          element.title?.toLowerCase().contains(query.toLowerCase()) ?? false,
    );

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: context.padding.horizontalLow,
          child: Card(
            child: ListTile(
              onTap: () {
                context.route.navigateToPage(SelectedItemPage(
                  carsItem: results.elementAt(index),
                ));
              },
              title: Text(results.elementAt(index).title ?? ''),
              subtitle: Text(results.elementAt(index).category ?? ''),
              trailing: Image.network(
                results.elementAt(index).backgroundImage ?? '',
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final results =
        carItems.where((element) => element.title?.contains(query) ?? false);

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: context.padding.horizontalLow,
          child: Card(
            child: ListTile(
              onTap: () {
                context.route.navigateToPage(SelectedItemPage(
                  carsItem: results.elementAt(index),
                ));
              },
              title: Text(results.elementAt(index).title ?? ''),
              subtitle: Text(results.elementAt(index).category ?? ''),
              trailing: ClipRRect(
                borderRadius: context.border.lowBorderRadius,
                child: Image.network(
                  results.elementAt(index).backgroundImage ?? '',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
