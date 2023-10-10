import 'package:carstore/feauture/home/home_view.dart';
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
    ref.read(splashProvider.notifier).checkAppliactionVersion('1.0.0');
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(splashProvider, (previous, next) {
      if (next.isRequriedForceUpdate ?? false) {
        showAboutDialog(context: context);
        return;
      }
      if (next.isRedirectHome != null) {
        // ignore: use_if_null_to_convert_nulls_to_bools
        if (next.isRedirectHome!) {
          context.route.navigateToPage(const HomeView());
        } else {
          // stay in page
        }
      }
    });
    return Scaffold(
      backgroundColor: ColorConstants.primaryOrange,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: context.padding.onlyTopLow,
            child: const WavyText(title: StringConstants.appName),
          ),
        ],
      )),
    );
  }
}
