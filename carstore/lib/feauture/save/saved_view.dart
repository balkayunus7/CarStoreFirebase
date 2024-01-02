import 'package:carstore/feauture/home/navigation_menu.dart';
import 'package:carstore/feauture/item/selected_item_view.dart';
import 'package:carstore/feauture/profile/providers/theme_provider.dart';
import 'package:carstore/feauture/save/providers/saved_provider.dart';
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

final _savedProvider = StateNotifierProvider<SavedNotifier, SavedState>((ref) {
  return SavedNotifier();
});

class SavedPage extends ConsumerStatefulWidget {
  const SavedPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SavedPageState();
}

class _SavedPageState extends ConsumerState<SavedPage> {
  @override
  Widget build(BuildContext context) {
    final cars = ref.watch(_savedProvider).selectedCars ?? [];
    // ignore: unused_local_variable
    final carss = ref.watch(_savedProvider.notifier).getSavedCars();
    final appThemeState = ref.watch(appThemeStateNotifier);
    return Scaffold(
      appBar: CustomAppBar(StringConstants.savedPageTitle,
          iconColor: appThemeState.isDarkModeEnabled == false
              ? ColorConstants.primaryDark
              : Colors.white,
          preferredSize: const Size.fromHeight(kToolbarHeight),
          onPressed: () => context.route.navigateToPage(const NavigationMenu()),
          child: const SizedBox.shrink()),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1, mainAxisSpacing: 2),
        itemCount: cars.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: context.padding.low,
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    context.route.navigateToPage(SelectedItemPage(
                      carsItem: cars[index],
                    ));
                  },
                  child: Card(
                    color: appThemeState.isDarkModeEnabled == false
                        ? Colors.transparent
                        : Colors.white38,
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
                ),
                Positioned(
                    left: 170,
                    top: 5,
                    child: IconAppBar(
                        onPressed: () {
                          ref
                              .read(_savedProvider.notifier)
                              .deleteSavedCar(cars[index])
                              .then((value) => ref
                                  .read(_savedProvider.notifier)
                                  .getSavedCars());
                        },
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
