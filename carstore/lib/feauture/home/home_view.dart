import 'package:carstore/feauture/home/providers/home_provider.dart';
import 'package:carstore/feauture/home/sub_view/home_chips.dart';
import 'package:carstore/feauture/home/sub_view/home_search_delegate.dart';
import 'package:carstore/feauture/profile/providers/theme_provider.dart';
import 'package:carstore/product/constants/color_constants.dart';
import 'package:carstore/product/constants/string_constants.dart';
import 'package:carstore/product/widget/card/home_news_card.dart';
import 'package:carstore/product/widget/card/recommanded_card.dart';
import 'package:carstore/product/widget/text/subtitle_text.dart';
import 'package:carstore/product/widget/text/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

import '../../product/enums/index.dart';

// * State notifier provider created to be used
final _homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier();
});

// * Main home view widget
class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  // *  It is used to capture car data in the firebase in the provider object.
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(_homeProvider.notifier).fetchAndLoad());
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: context.padding.normal,
              children: [
                Header(),
                _CustomTextfield(),
                _TagsListview(),
                _BrowseHorizontalListview(),
                _RecommendedHeader(),
                _RecommendedWidget(),
              ],
            ),
            if (ref.watch(_homeProvider).isLoading ?? false)
              const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}

//* Header for home page titles
class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: context.padding.onlyTopMedium,
          child: const TitleText(
              title: StringConstants.homeBrowse,
              color: ColorConstants.primaryOrange),
        ),
        Padding(
          padding: context.padding.verticalLow,
          child: const SubtitleText(
            subtitle: StringConstants.homeMessage,
            color: ColorConstants.primaryGrey,
          ),
        ),
      ],
    );
  }
}

//* Custom textfield widget for search
class _CustomTextfield extends ConsumerWidget {
  const _CustomTextfield();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      onTap: () {
        showSearch(
          context: context,
          delegate: HomeSearchDelegate(
            ref.read(_homeProvider.notifier).fullCarList,
          ),
        );
      },
      decoration: InputDecoration(
        filled: true,
        hintText: StringConstants.textfieldSearch,
        hintStyle: context.general.textTheme.bodyMedium!
            .copyWith(color: ColorConstants.primaryDark),
        prefixIcon: const Icon(Icons.search),
        prefixIconColor: ColorConstants.primaryDark,
        fillColor: ColorConstants.textFieldGrey,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: WidgetSizeConstants.borderRadiusNormal,
        ),
      ),
    );
  }
}

//* Tags for category tags
class _TagsListview extends ConsumerWidget {
  const _TagsListview();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagItems = ref.watch(_homeProvider).tag ?? [];
    return SizedBox(
      height: context.sized.dynamicHeight(.1),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tagItems.length,
        itemBuilder: (context, index) {
          final tagItem = tagItems[index];
          if (tagItem.active ?? false) {
            return ActiveChip(
              tag: tagItem,
            );
          }
          return PassiveChip(
            tag: tagItem,
          );
        },
      ),
    );
  }
}

// Browse Horizontal Listview for browse cars listview
class _BrowseHorizontalListview extends ConsumerWidget {
  const _BrowseHorizontalListview();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carsItems = ref.watch(_homeProvider).cars;
    return SizedBox(
      height: context.sized.dynamicHeight(0.24),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: carsItems?.length ?? 0,
        itemBuilder: (context, index) {
          return HomeNewsCard(
            onPressed: () {
              ref
                  .watch(_homeProvider.notifier)
                  .saveSelectedCar(carsItems![index]);
            },
            carsItem: carsItems?[index],
          );
        },
      ),
    );
  }
}

// RecommendedHeader for recommended cars card widgets titles
class _RecommendedHeader extends ConsumerWidget {
  const _RecommendedHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeState = ref.watch(appThemeStateNotifier);
    return Padding(
      padding: context.padding.onlyTopLow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           TitleText(
            title: StringConstants.homeTitle,
            color: appThemeState.isDarkModeEnabled == false ? ColorConstants.primaryDark :ColorConstants.primaryWhite,
          ),
          TextButton(
            onPressed: () {},
            child: const SubtitleText(
              subtitle: StringConstants.homeSeeAll,
              color: ColorConstants.primaryGrey,
            ),
          ),
        ],
      ),
    );
  }
}

// RecomandedWidget for recommanded cars card widgets
class _RecommendedWidget extends ConsumerWidget {
  const _RecommendedWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recommandedList = ref.watch(_homeProvider).recommended ?? [];
    return ListView.builder(
      itemCount: recommandedList.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return RecommandedCard(
          recommended: recommandedList[index],
        );
      },
    );
  }
}
