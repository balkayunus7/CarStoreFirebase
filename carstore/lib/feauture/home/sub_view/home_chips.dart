import 'package:carstore/feauture/profile/theme_provider.dart';
import 'package:carstore/product/constants/color_constants.dart';
import 'package:carstore/product/models/tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

class ActiveChip extends ConsumerWidget {
  const ActiveChip({required this.tag, super.key});
  final Tag tag;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final appThemeState = ref.watch(appThemeStateNotifier);
    return Padding(
      padding: context.padding.low,
      child: Chip(
        label: Text(
          tag.name ?? '',
          style: context.general.textTheme.bodySmall
              ?.copyWith(color:appThemeState.isDarkModeEnabled == false ? ColorConstants.primaryWhite :ColorConstants.primaryWhite,fontWeight: FontWeight.w600) ),
        backgroundColor: ColorConstants.primaryOrange,
        padding: context.padding.low,
      ),
    );
  }
}

class PassiveChip extends ConsumerWidget {
  const PassiveChip({required this.tag, super.key});
  final Tag tag;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final appThemeState = ref.watch(appThemeStateNotifier);

    return Padding(
      padding: context.padding.low,
      child: Chip(
        label: Text(
          tag.name ?? '',
          style: context.general.textTheme.bodySmall
              ?.copyWith(color:appThemeState.isDarkModeEnabled == false ? ColorConstants.primaryDark :ColorConstants.primaryDark,fontWeight: FontWeight.w600) ),
        backgroundColor: Colors.grey.shade300,
        padding: context.padding.low,
      ),
    );
  }
}
