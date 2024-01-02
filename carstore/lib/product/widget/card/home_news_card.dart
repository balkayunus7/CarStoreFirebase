import 'package:carstore/feauture/item/selected_item_view.dart';
import 'package:carstore/product/constants/color_constants.dart';
import 'package:carstore/product/models/cars.dart';
import 'package:carstore/product/widget/text/subtitle_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';


class HomeNewsCard extends ConsumerWidget {
  const HomeNewsCard(
      {required this.carsItem, super.key, required this.onPressed});

  final Cars? carsItem;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (carsItem == null) return const SizedBox.shrink();

    return Stack(
      children: [
        Padding(
          padding: context.padding.onlyRightNormal,
          child: GestureDetector(
            onTap: () {
              context.route.navigateToPage(
                SelectedItemPage(
                  carsItem: carsItem,
                ),
              );
            },
            child: Card(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    width: 220,
                    height: 150,
                    child: Image.network(
                      carsItem!.backgroundImage ?? '',
                    ),
                  ),
                  SubtitleText(
                    subtitle: carsItem!.category ?? '',
                    color: ColorConstants.primaryOrange,
                  ),
                  Text(
                    carsItem!.title ?? '',
                    style: context.general.textTheme.headlineSmall?.copyWith(
                      color: ColorConstants.primaryOrange,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding: context.padding.onlyRightNormal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: onPressed,
                  icon: const Icon(
                          Icons.favorite,
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
