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
          child: Positioned.fill(
            child: Card(
              color: Colors.white,
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: context.border.lowBorderRadius,
                        child: Image.network(
                          carsItem!.backgroundImage ?? '',
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0),
                                Colors.white.withOpacity(0.1),
                                Colors.white.withOpacity(0.1),
                                Colors.white.withOpacity(0.2),
                                Colors.white.withOpacity(0.4),
                                Colors.white.withOpacity(1),
                              ],
                              begin: Alignment.center,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                    ],
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
                  onPressed: () {},
                  icon: Icon(
                    Icons.bookmark_add_outlined,
                    size: WidgetSize.iconNormal.value.toDouble(),
                    color: ColorConstants.primaryGrey,
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
