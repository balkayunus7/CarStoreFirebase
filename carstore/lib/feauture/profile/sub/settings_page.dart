import 'package:carstore/feauture/auth/sub_view.dart/custom_textform.dart';
import 'package:carstore/feauture/item/selected_item_view.dart';
import 'package:carstore/feauture/profile/profile_provider.dart';
import 'package:carstore/product/constants/color_constants.dart';
import 'package:carstore/product/constants/string_constants.dart';
import 'package:carstore/product/enums/image_constants.dart';
import 'package:carstore/product/widget/app_bar/custom_appbar.dart';
import 'package:carstore/product/widget/text/subtitle_text.dart';
import 'package:carstore/product/widget/text/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

final profilProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier();
});

// ignore: must_be_immutable
class SettingsPage extends ConsumerWidget {
   SettingsPage({super.key});
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _againPassworldController = TextEditingController();

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(
        'Settings',
        iconColor: ColorConstants.primaryDark,
        onPressed: () {
        context.route.pop();
        },
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: const SizedBox.shrink(),
      ),
      body: Column(
        children: [
          Center(
            child:Padding(
              padding: context.padding.normal,
              child: IconConstants.lock.toImage,
            ),
          ),
          TitleText(title: StringConstants.titlePassword, color: ColorConstants.primaryOrange),
          Padding(
            padding: context.padding.normal,
            child: SubtitleText(subtitle: StringConstants.titlePasswordMessage, color: ColorConstants.primaryDark),
          ),
          const SizedBox(height:50),
          Padding(
            padding: context.padding.horizontalNormal,
            child: CustomTextfield(controller: _passwordController, hintText: StringConstants.passworld, obscureText: false, icon: Icons.lock),
          ),
          Padding(
            padding: context.padding.normal,
            child: CustomTextfield(controller: _againPassworldController, hintText: StringConstants.confirmPassword, obscureText: false, icon: Icons.lock),
          ),
          Padding(
            padding: context.padding.normal,
            child: Padding(
              padding: context.padding.horizontalMedium,
              child: BuyButton(
                onPressed: () {
                  if (_passwordController.text == _againPassworldController.text) {
                    ref.watch(profilProvider.notifier).ChangePassword(_passwordController.text, _againPassworldController.text).then((value) => context.route.pop());
                  }
                  else {
                    showAboutDialog(context: context, applicationName: StringConstants.passwordDialogText, applicationVersion:StringConstants.passwordDialogMessage);
                  }
                },
                iconText:StringConstants.iconPasswordtext,
              ),
            ),
          ),
        ],
      )

    );
  }
}