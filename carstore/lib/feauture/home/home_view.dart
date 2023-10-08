import 'package:carstore/product/models/cars.dart';
import 'package:carstore/product/utilities/exception/custom_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // FutureBuilder ile veri çekme işlemi
  // ya da Data init olduğu anda veri çekip set state ile güncelleme
  @override
  Widget build(BuildContext context) {
    final CollectionReference cars =
        FirebaseFirestore.instance.collection('cars');

    final response = cars.withConverter(
      fromFirestore: (snapshot, options) {
        return Cars().fromFirebase(snapshot);
      },
      toFirestore: (value, options) {
        if (value == null) throw CustomFirebaseException('$value is null');
        return value.toJson();
      },
    ).get();

    return Scaffold(
      appBar: AppBar(),
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
              if (snapshot.hasData) {
                final values =
                    snapshot.data!.docs.map((e) => e.data()).toList();
                return ListView.builder(
                  itemCount: values.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          Image.network(
                            values[index]?.backgroundImage ?? '',
                            height: context.sized.dynamicHeight(.1),
                          ),
                          Text(
                            values[index]?.title ?? '',
                            style: context.general.textTheme.labelLarge,
                          )
                        ],
                      ),
                    );
                  },
                );
              } else {
                return const SizedBox();
              }
          }
        },
      ),
    );
  }
}
