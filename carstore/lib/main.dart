import 'package:carstore/feauture/profile/providers/theme_provider.dart';
import 'package:carstore/feauture/splash/splash_view.dart';
import 'package:carstore/product/constants/string_constants.dart';
import 'package:carstore/product/initealize/app_builder.dart';
import 'package:carstore/product/initealize/app_theme.dart';
import 'package:carstore/product/initealize/application_start.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



Future<void> main() async {
  await AppliactionStart.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final appThemeState = ref.watch(appThemeStateNotifier);
    return MaterialApp(
      builder: (context, child) => AppBuilder(child).build(),
      title: StringConstants.appName,
      debugShowCheckedModeBanner: false,
      home: const SplashView(),
      theme:appThemeState.isDarkModeEnabled ? darkMode: AppTheme(context: context).theme,
      darkTheme: darkMode,
    );
  }
}
