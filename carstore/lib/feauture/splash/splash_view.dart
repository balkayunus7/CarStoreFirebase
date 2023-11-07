import 'package:carstore/feauture/auth/login_view.dart';
import 'package:carstore/feauture/splash/splash_provider.dart';
import 'package:carstore/product/constants/color_constants.dart';
import 'package:carstore/product/constants/string_constants.dart';
import 'package:carstore/product/enums/image_constants.dart';
import 'package:carstore/product/widget/text/wavy_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView>
    with _SplashViewListenMixin {
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
    listenAndNavigate(splashProvider);
    return Scaffold(
      backgroundColor: ColorConstants.primaryOrange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconConstants.logo.toImage,
            Padding(
              padding: context.padding.onlyTopLow,
              child: const WavyText(title: StringConstants.appName),
            ),
          ],
        ),
      ),
    );
  }
}

mixin _SplashViewListenMixin on ConsumerState<SplashView> {
  void listenAndNavigate(
    StateNotifierProvider<SplashProvider, SplashState> provider,
  ) {
    ref.listen(provider, (previous, next) {
      if (next.isRequriedForceUpdate ?? false) {
        //  showAboutDialog(context: context);
        return;
      }
      if (next.isRedirectHome != null) {
        if (next.isRedirectHome!) {
          Future.delayed(const Duration(milliseconds: 2200), () {
            context.route.navigateToPage(LoginPage());
          });
        } else {
          // false
        }
      }
    });
  }
}
