import 'package:carstore/product/constants/color_constants.dart';
import 'package:carstore/product/models/tag.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ActiveChip extends StatelessWidget {
  const ActiveChip({required this.tag, super.key});
  final Tag tag;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.normal,
      child: Chip(
        label: Text(
          tag.name ?? '',
          style: context.general.textTheme.bodySmall
              ?.copyWith(color: ColorConstants.primaryWhite),
        ),
        backgroundColor: ColorConstants.primaryOrange,
        padding: context.padding.low,
      ),
    );
  }
}

class PassiveChip extends StatelessWidget {
  const PassiveChip({required this.tag, super.key});
  final Tag tag;

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: context.padding.onlyRightLow,
      label: Text(
        tag.name ?? '',
        style: context.general.textTheme.bodySmall
            ?.copyWith(color: ColorConstants.primaryWhite),
      ),
      backgroundColor: Colors.grey.shade300,
      padding: context.padding.low,
    );
  }
}
