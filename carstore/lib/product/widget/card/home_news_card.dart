import 'package:carstore/product/constants/color_constants.dart';
import 'package:carstore/product/enums/widget_sizes.dart';
import 'package:carstore/product/models/cars.dart';
import 'package:carstore/product/widget/text/subtitle_text.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class HomeNewsCard extends StatelessWidget {
  const HomeNewsCard({required this.carsItem, super.key});

  final Cars? carsItem;

  @override
  Widget build(BuildContext context) {
    if (carsItem == null) return const SizedBox.shrink();

    return Stack(
      children: [
        Padding(
          padding: context.padding.onlyRightNormal,
          child: Image.network(carsItem!.backgroundImage ?? ''),
        ),
        Positioned.fill(
          child: Padding(
            padding: context.padding.onlyRightNormal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.bookmark_add_outlined,
                    size: WidgetSize.iconNormal.value.toDouble(),
                    color: ColorConstants.primaryGrey,
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(top: 60, right: 27),
                  child: Column(
                    children: [
                      SubtitleText(
                        subtitle: carsItem!.category ?? '',
                        color: ColorConstants.primaryWhite,
                      ),
                      Text(
                        carsItem!.title ?? '',
                        style: context.general.textTheme.bodyLarge
                            ?.copyWith(color: ColorConstants.primaryWhite),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
