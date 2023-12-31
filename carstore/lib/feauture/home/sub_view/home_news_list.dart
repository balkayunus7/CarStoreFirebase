import 'package:carstore/product/constants/string_constants.dart';
import 'package:carstore/product/models/cars.dart';
import 'package:carstore/product/utilities/exception/custom_exception.dart';
import 'package:carstore/product/utilities/firebase/firebase_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class HomeListView extends StatelessWidget {
  const HomeListView({super.key});

  @override
  Widget build(BuildContext context) {
    final cars = FirebaseCollections.cars.reference;

    final response = cars.withConverter(
      fromFirestore: (snapshot, options) {
        return Cars().fromFirebase(snapshot);
      },
      toFirestore: (value, options) {
        // ignore: unnecessary_null_comparison
        if (value == null) throw CustomFirebaseException('$value is null');
        return value.toJson();
      },
    ).get();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(StringConstants.appName),
      ),
      body: FutureBuilder(
        future: response,
        builder: (context, AsyncSnapshot<QuerySnapshot<Cars?>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Placeholder();
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const LinearProgressIndicator();
            case ConnectionState.done:
              // Snapshot has data
              if (snapshot.hasData) {
                final values =
                    snapshot.data!.docs.map((e) => e.data()).toList();
                return ListView.builder(
                  itemCount: 1,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Card(
                        child: Column(
                          children: [
                            Image.network(
                              values[index]?.backgroundImage ?? '',
                              height: context.sized.dynamicHeight(.1),
                            ),
                            Text(
                              values[index]?.title ?? '',
                              style: context.general.textTheme.labelLarge,
                            ),
                            Text(values[index]?.category ?? ''),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              // snapshot has no data show sizedbox
              else {
                return const SizedBox();
              }
          }
        },
      ),
    );
  }
}
