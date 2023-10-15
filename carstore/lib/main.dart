import 'package:carstore/feauture/home/home_view.dart';
import 'package:carstore/product/constants/string_constants.dart';
import 'package:carstore/product/initealize/app_theme.dart';
import 'package:carstore/product/initealize/application_start.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  await AppliactionStart.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringConstants.appName,
      debugShowCheckedModeBanner: false,
      home: const HomeView(),
      theme: AppTheme(context: context).theme,
    );
  }
}
