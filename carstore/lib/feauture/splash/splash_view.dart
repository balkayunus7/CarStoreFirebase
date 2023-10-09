import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carstore/product/constants/color_constants.dart';
import 'package:carstore/product/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

class SplashView extends ConsumerWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: AnimatedTextKit(
          animatedTexts: [
            WavyAnimatedText(
              StringConstants.appName,
              textStyle: context.general.textTheme.headlineSmall?.copyWith(
                color: ColorConstants.primaryWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
