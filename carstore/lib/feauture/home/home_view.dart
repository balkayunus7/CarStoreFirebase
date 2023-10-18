import 'package:carstore/feauture/home/home_provider.dart';
import 'package:carstore/feauture/home/sub_view/home_chips.dart';
import 'package:carstore/product/constants/color_constants.dart';
import 'package:carstore/product/constants/string_constants.dart';
import 'package:carstore/product/enums/image_sizes.dart';
import 'package:carstore/product/widget/card/home_news_card.dart';
import 'package:carstore/product/widget/text/subtitle_text.dart';
import 'package:carstore/product/widget/text/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

final _homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier();
});

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(_homeProvider.notifier).fetchCars();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: ListView(
          padding: context.padding.normal,
          children: const [
            Header(),
            _CustomTextfield(),
            _TagsListview(),
            _BrowseHorizontalListview(),
            _RecommendedHeader(),
            _RecommendedWidget(),
          ],
        ),
      ),
    );
  }
}

// Custom textfield for search

class _CustomTextfield extends StatelessWidget {
  const _CustomTextfield();

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        hintText: StringConstants.textfieldSearch,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: const Icon(Icons.mic_outlined),
        fillColor: ColorConstants.textFieldGrey,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

// Tags for search tags
class _TagsListview extends StatelessWidget {
  const _TagsListview();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.sized.dynamicHeight(.1),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          if (index.isOdd) {
            return const ActiveChip();
          }
          return const PassiveChip();
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
      height: context.sized.dynamicHeight(.2),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: carsItems?.length ?? 0,
        itemBuilder: (context, index) {
          return HomeNewsCard(
            carsItem: carsItems?[index],
          );
        },
      ),
    );
  }
}

// RecommendedHeader for recommended cars card widgets titles
class _RecommendedHeader extends StatelessWidget {
  const _RecommendedHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.onlyTopLow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: TitleText(
              title: StringConstants.homeTitle,
              color: Colors.black,
            ),
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

// RecomandedWidget for recemanded cars card widgets
class _RecommendedWidget extends StatelessWidget {
  const _RecommendedWidget();

  static const dummyImage =
      'https://firebasestorage.googleapis.com/v0/b/car-store-615be.appspot.com/o/Rectangle%2013.png?alt=media&token=2841a39e-0db2-4ec3-8763-d587fbf76726&_gl=1*1ppf73v*_ga*MTg0MjQxMzcyNy4xNjk2Njg4MTAw*_ga_CW55HF8NVT*MTY5NzM4ODEzNy4xMi4xLjE2OTczOTA1NTguNjAuMC4w';

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return const _RecommandedCard(dummyImage: dummyImage);
      },
    );
  }
}

class _RecommandedCard extends StatelessWidget {
  const _RecommandedCard({
    required this.dummyImage,
  });

  final String dummyImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.onlyTopLow,
      child: Row(
        children: [
          Image.network(
            dummyImage,
            width: ImageSize.normal.value.toDouble(),
            height: ImageSize.normal.value.toDouble(),
          ),
          const Expanded(
            child: ListTile(
              title: Text('UI/UX DESIGN'),
              subtitle: Text('A simple Trick For Creating Palettes Quickly'),
            ),
          ),
        ],
      ),
    );
  }
}

// Header for home page titles
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
