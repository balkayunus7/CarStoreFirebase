import 'package:carstore/feauture/splash/splash_provider.dart';
import 'package:carstore/product/constants/color_constants.dart';
import 'package:carstore/product/constants/string_constants.dart';
import 'package:carstore/product/widget/text/wavy_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  // Splash Provider defined
  final splashProvider =
      StateNotifierProvider<SplashProvider, SplashState>((ref) {
    return SplashProvider();
  });

  @override
  void initState() {
    super.initState();
    // Old and new states in splashProvider were compared with the Listen method
    ref.listen(splashProvider, (previous, next) {
      if (next.isRequriedForceUpdate ?? false) {
        showAboutDialog(context: context);
        return;
      }
      if (next.isRedirectHome != null) {
        // ignore: use_if_null_to_convert_nulls_to_bools
        if (next.isRedirectHome == true) {
          // got to page
        } else {
          // stay in page
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorConstants.primaryOrange,
      body: Center(child: WavyText(title: StringConstants.appName)),
    );
  }
}
