import 'package:carstore/feauture/auth/sub_view.dart/custom_textform.dart';
import 'package:carstore/feauture/item/selected_item_view.dart';
import 'package:carstore/feauture/profile/providers/profile_provider.dart';
import 'package:carstore/feauture/profile/providers/theme_provider.dart';
import 'package:carstore/product/constants/color_constants.dart';
import 'package:carstore/product/constants/string_constants.dart';
import 'package:carstore/product/enums/image_constants.dart';
import 'package:carstore/product/enums/widget_sizes.dart';
import 'package:carstore/product/widget/app_bar/custom_appbar.dart';
import 'package:carstore/product/widget/text/subtitle_text.dart';
import 'package:carstore/product/widget/text/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

// * State notifier provider created to be used in the profile page
final _profilProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier();
});

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {

  final TextEditingController _emailController = TextEditingController();
  
   @override
  void initState() {
    super.initState();
    ref.read(_profilProvider.notifier).getCurrentUser();
  }
  @override
   Widget build(BuildContext context) {
    final appTheme = ref.watch(appThemeStateNotifier);
    return Scaffold(
        appBar: CustomAppBar(
          'Settings',
          iconColor: appTheme.isDarkModeEnabled
              ? ColorConstants.primaryWhite
              : ColorConstants.primaryOrange,
          onPressed: () {
            context.route.pop();
          },
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: const SizedBox.shrink(),
        ),
        body: Column(
          children: [
            Center(
              child: Padding(
                padding: context.padding.normal,
                child: IconConstants.lock.toImage,
              ),
            ),
            TitleText(
                title: StringConstants.titlePassword,
                color: appTheme.isDarkModeEnabled
                    ? ColorConstants.primaryWhite
                    : ColorConstants.primaryOrange),
            Padding(
              padding: context.padding.normal,
              child: SubtitleText(
                  subtitle: StringConstants.titlePasswordMessage,
                  color: appTheme.isDarkModeEnabled
                      ? ColorConstants.primaryWhite
                      : ColorConstants.primaryDark),
            ),
            SizedBox(height: WidgetSize.sizedBoxBig.value),
            Padding(
              padding: context.padding.horizontalNormal,
              child: CustomTextfield(
                  controller: _emailController,
                  hintText: StringConstants.hintTextEmail,
                  iconFirst: Icons.email_outlined),
            ),
            Padding(
              padding: context.padding.normal,
              child: Padding(
                padding: context.padding.horizontalMedium,
                child: BuyButton(
                  onPressed: () {
                       ref
                          .watch(_profilProvider.notifier)
                          .changePassword(_emailController.text.trim(),
                              )
                          .then((value) => showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              title: Text(StringConstants.titlePassword),
                              content: Text(StringConstants.titlePasswordMessage),
                            );
                          }).then((value) => context.route.pop())); 
                    } ,
                  iconText: StringConstants.iconPasswordtext,
                ),
              ),
            ),
          ],
        ));
  }
}
