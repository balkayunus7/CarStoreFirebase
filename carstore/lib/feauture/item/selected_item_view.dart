import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:carstore/feauture/item/sub_view/icon_appbar.dart';
import 'package:carstore/product/constants/color_constants.dart';
import 'package:carstore/product/constants/string_constants.dart';
import 'package:carstore/product/models/cars.dart';
import 'package:carstore/product/widget/text/subtitle_text.dart';
import 'package:carstore/product/widget/text/title_text.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SelectedItemPage extends StatefulWidget {
  const SelectedItemPage({super.key, this.carsItem});
  final Cars? carsItem;

  @override
  State<SelectedItemPage> createState() => _SelectedItemPageState();
}

class _SelectedItemPageState extends State<SelectedItemPage> {
  final PageController _pageController = PageController();

  late CustomVideoPlayerController _customVideoPlayerController;
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    VideoPlayer();
  }

  void VideoPlayer() {
    _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.carsItem?.videoUrl ?? ''))
      ..initialize().then((value) => setState(() {}));
    _customVideoPlayerController = CustomVideoPlayerController(
        context: context, videoPlayerController: _videoPlayerController);
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _CustomAppBar(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: const SizedBox.shrink()),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: context.padding.verticalMedium,
              child: Column(
                children: [
                  // * Car Image and Title, Description

                  Stack(
                    children: [
                      SizedBox(
                        height: context.sized.dynamicHeight(0.4),
                        child: Padding(
                          padding: const EdgeInsets.all(40),
                          child: PageView(
                            controller: _pageController,
                            children: [
                              Image.network(
                                widget.carsItem?.backgroundImage ?? '',
                              ),
                              Image.network(
                                widget.carsItem?.backgroundImage2 ?? '',
                              ),
                              Image.network(
                                widget.carsItem?.backgroundImage3 ?? '',
                              ),
                              CustomVideoPlayer(
                                customVideoPlayerController:
                                    _customVideoPlayerController,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: 4,
                    effect: ExpandingDotsEffect(
                      dotColor: ColorConstants.primaryOrange,
                      activeDotColor: ColorConstants.primaryDark,
                      dotHeight: 20,
                      dotWidth: 15,
                      spacing: 4,
                    ),
                  ),
                  // * Title and Description
                  Padding(
                    padding: context.padding.horizontalMedium.copyWith(
                      bottom: 20,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: context.padding.onlyRightMedium,
                          child: TitleText(
                            title: widget.carsItem?.title ?? '',
                            color: ColorConstants.primaryDark,
                          ),
                        ),
                        Text(
                          widget.carsItem?.price ?? '',
                          style: context.general.textTheme.headlineMedium
                              ?.copyWith(
                            color: ColorConstants.primaryOrange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: context.padding.horizontalMedium,
                    child: SubtitleText(
                      subtitle: widget.carsItem?.description ?? '',
                      color: ColorConstants.primaryDark,
                    ),
                  ),
                  // * Tags for car detail
                  Padding(
                    padding: context.padding.onlyTopNormal,
                    child: Column(
                      //*  Tag Details for _TagWidget
                      children: [
                        const _TagWidget(
                          textFirstTag: StringConstants.tagHandshake,
                          textSecondTag: StringConstants.tagCarDetail,
                          iconSecond: Icons.minor_crash_rounded,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          iconFirst: Icons.handshake_outlined,
                        ),
                        Padding(
                          padding: context.padding.horizontalNormal.copyWith(
                            bottom: 20,
                          ),
                          child: const _TagWidget(
                            textFirstTag: StringConstants.tagLocation,
                            textSecondTag: StringConstants.tagMoneyDetail,
                            iconSecond: Icons.attach_money_outlined,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            iconFirst: Icons.location_on_outlined,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // * Buy Button
                  const _BuyButton()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomAppBar extends PreferredSize {
  _CustomAppBar({required super.preferredSize, required super.child});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconAppBar(
        iconColor: ColorConstants.primaryDark,
        iconData: Icons.arrow_back,
        onPressed: () {
          context.route.pop();
        },
      ),
      actions: [
        IconAppBar(
          onPressed: () {},
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
    );
  }
}

// * Buy Button of Car Details Page
class _BuyButton extends StatelessWidget {
  const _BuyButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.horizontalNormal,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith(
            (states) => ColorConstants.primaryOrange,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: context.border.lowBorderRadius,
            ),
          ),
        ),
        onPressed: () {},
        child: const SizedBox(
          width: double.infinity,
          height: 65,
          child: Center(
            child: Text(
              StringConstants.iconText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

// * Tags for car detail
class _TagWidget extends StatelessWidget {
  const _TagWidget({
    required this.iconFirst,
    required this.iconSecond,
    required this.textFirstTag,
    required this.textSecondTag,
    required this.mainAxisAlignment,
  });

  final IconData iconFirst;
  final IconData iconSecond;

  final String textFirstTag;
  final String textSecondTag;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Row(
          children: [
            IconAppBar(
              onPressed: () {},
              iconColor: ColorConstants.primaryDark,
              iconData: iconFirst,
            ),
            SubtitleText(
              subtitle: textFirstTag,
              color: ColorConstants.primaryDark,
            ),
          ],
        ),
        Row(
          children: [
            IconAppBar(
              onPressed: () {},
              iconColor: ColorConstants.primaryDark,
              iconData: iconSecond,
            ),
            SubtitleText(
              subtitle: textSecondTag,
              color: ColorConstants.primaryDark,
            ),
          ],
        ),
      ],
    );
  }
}
