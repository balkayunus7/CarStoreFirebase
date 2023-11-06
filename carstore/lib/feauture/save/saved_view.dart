import 'package:carstore/feauture/home/navigation_menu.dart';
import 'package:carstore/feauture/save/saved_provider.dart';
import 'package:carstore/product/constants/color_constants.dart';
import 'package:carstore/product/constants/string_constants.dart';
import 'package:carstore/product/enums/image_sizes.dart';
import 'package:carstore/product/widget/app_bar/custom_appbar.dart';
import 'package:carstore/product/widget/icon_button/custom_icon_button.dart';
import 'package:carstore/product/widget/text/subtitle_text.dart';
import 'package:carstore/product/widget/text/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

class SavedPage extends ConsumerStatefulWidget {
  const SavedPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SavedPageState();
}

class _SavedPageState extends ConsumerState<SavedPage> {
  final _savedProvider =
      StateNotifierProvider<SavedNotifier, SavedState>((ref) {
    return SavedNotifier();
  });
  @override
  Widget build(BuildContext context) {
    final cars = ref.watch(_savedProvider).selectedCars ?? [];
    // ignore: unused_local_variable
    final carss = ref.watch(_savedProvider.notifier).getSavedCars();

    return Scaffold(
      appBar: CustomAppBar(StringConstants.savedPageTitle,
          preferredSize: Size.fromHeight(kToolbarHeight),
          onPressed: () => context.route.navigateToPage(NavigationMenu()),
          child: const SizedBox.shrink()),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1, mainAxisSpacing: 2),
        itemCount: cars.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: context.padding.low,
            child: Stack(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: context.border.normalBorderRadius,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: ImageSize.cardWidth.value.toDouble(),
                        height: ImageSize.cardHeight.value.toDouble(),
                        child: Image.network(
                          cars[index].backgroundImage.toString(),
                        ),
                      ),
                      Padding(
                        padding: context.padding.onlyTopLow,
                        child: SubtitleText(
                          subtitle: cars[index].title.toString(),
                          color: ColorConstants.primaryOrange,
                        ),
                      ),
                      TitleText(
                        title: cars[index].price.toString(),
                        color: ColorConstants.primaryOrange,
                      ),
                    ],
                  ),
                ),
                Positioned(
                    left: 170,
                    top: 5,
                    child: IconAppBar(
                        onPressed: () {},
                        iconColor: ColorConstants.primaryRed,
                        iconData: Icons.favorite)),
              ],
            ),
          );
        },
      ),
    );
  }
}
