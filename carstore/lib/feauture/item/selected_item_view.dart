import 'package:carstore/feauture/item/sub_view/icon_appbar.dart';
import 'package:carstore/product/constants/color_constants.dart';
import 'package:carstore/product/constants/string_constants.dart';
import 'package:carstore/product/models/cars.dart';
import 'package:carstore/product/widget/text/subtitle_text.dart';
import 'package:carstore/product/widget/text/title_text.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class SelectedItemPage extends StatelessWidget {
  const SelectedItemPage({super.key, this.carsItem});
  final Cars? carsItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const IconAppBar(
          iconColor: Colors.black,
          iconData: Icons.arrow_back,
        ),
        actions: const [
          IconAppBar(
            iconColor: ColorConstants.primaryDark,
            iconData: Icons.share,
          ),
        ],
        centerTitle: true,
        title: const TitleText(
          title: StringConstants.appName,
          color: ColorConstants.primaryOrange,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Column(
            children: [
              SizedBox(
                height: context.sized.dynamicHeight(0.4),
                child: ClipRRect(
                  borderRadius: context.border.lowBorderRadius,
                  child: Image.network(carsItem?.backgroundImage ?? ''),
                ),
              ),
              TitleText(
                title: carsItem?.title ?? '',
                color: ColorConstants.primaryDark,
              ),
              Padding(
                padding: context.padding.horizontalNormal,
                child: SubtitleText(
                  subtitle: carsItem?.description ?? '',
                  color: ColorConstants.primaryDark,
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: context.padding.horizontalNormal,
                    child: const Row(
                      children: [
                        Row(
                          children: [
                            IconAppBar(
                                iconColor: ColorConstants.primaryDark,
                                iconData: Icons.handshake_outlined),
                            SubtitleText(
                              subtitle: 'Contact Dealer',
                              color: ColorConstants.primaryDark,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconAppBar(
                                iconColor: ColorConstants.primaryDark,
                                iconData: Icons.handshake_outlined),
                            SubtitleText(
                              subtitle: 'Contact Dealer',
                              color: ColorConstants.primaryDark,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: context.padding.horizontalNormal,
                    child: const Row(
                      children: [
                        Row(
                          children: [
                            IconAppBar(
                                iconColor: ColorConstants.primaryDark,
                                iconData: Icons.handshake_outlined),
                            SubtitleText(
                              subtitle: 'Contact Dealer',
                              color: ColorConstants.primaryDark,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconAppBar(
                                iconColor: ColorConstants.primaryDark,
                                iconData: Icons.handshake_outlined),
                            SubtitleText(
                              subtitle: 'Contact Dealer',
                              color: ColorConstants.primaryDark,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
