import 'package:carstore/product/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ActiveChip extends StatelessWidget {
  const ActiveChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.normal,
      child: Chip(
        label: Text(
          'label active',
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
  const PassiveChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: context.padding.onlyRightLow,
      label: Text(
        'label passive',
        style: context.general.textTheme.bodySmall
            ?.copyWith(color: ColorConstants.primaryWhite),
      ),
      backgroundColor: Colors.grey.shade300,
      padding: context.padding.low,
    );
  }
}
