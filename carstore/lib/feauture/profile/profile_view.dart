import 'dart:io';

import 'package:carstore/feauture/auth/login_view.dart';
import 'package:carstore/feauture/auth/network/firebase_auth.dart';
import 'package:carstore/feauture/home/navigation_menu.dart';
import 'package:carstore/feauture/profile/profile_provider.dart';
import 'package:carstore/product/constants/color_constants.dart';
import 'package:carstore/product/constants/string_constants.dart';
import 'package:carstore/product/widget/app_bar/custom_appbar.dart';
import 'package:carstore/product/widget/text/subtitle_text.dart';
import 'package:carstore/product/widget/text/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
// * State notifier provider created to be used

final _profilProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier();
});

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(_profilProvider.notifier).getCurrentUser());
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(_profilProvider).currentUser;
    final FirebaseAuthClass _fAuth = FirebaseAuthClass();
    if (currentUser != null) {
      return Scaffold(
          appBar: CustomAppBar(StringConstants.profilePageTitle,
              preferredSize: Size.fromHeight(kToolbarHeight),
              onPressed: () => context.route.navigateToPage(NavigationMenu()),
              child: const SizedBox.shrink()),
          body: Padding(
            padding: context.padding.onlyTopNormal,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: FileImage(
                    File(currentUser.profilePhoto ?? ''),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TitleText(
                    title: currentUser.name ?? '',
                    color: ColorConstants.primaryDark),
                SizedBox(
                  height: 5,
                ),
                SubtitleText(
                    subtitle: currentUser.email ?? '',
                    color: ColorConstants.primaryDark),
                SizedBox(
                  height: 20,
                ),
                _BuyButton(() {
                  setState(() {
                    ref.read(_profilProvider.notifier).pickImage().then(
                        (value) => ref
                            .read(_profilProvider.notifier)
                            .getCurrentUser());
                  });
                }),
                Container(
                  height: 40,
                  color: Colors.transparent,
                ),
                _ProfileListtile(title: StringConstants.settingsText),
                _ProfileListtile(
                    title: StringConstants.themeText,
                    iconLead: Icons.brightness_4),
                _ProfileListtile(
                    title: StringConstants.userManageText,
                    iconLead: Icons.person),
                _ProfileListtile(
                    title: StringConstants.infoText, iconLead: Icons.info),
                GestureDetector(
                  onTap: () {
                    _fAuth.signOutUser();
                    context.route.navigateToPage(LoginPage());
                  },
                  child: _ProfileListtile(
                    title: StringConstants.logoutText,
                    iconLead: Icons.logout,
                    textColor: ColorConstants.primaryRed,
                    iconColor: ColorConstants.primaryRed,
                  ),
                ),
              ],
            ),
          ));
    } else {
      return SizedBox.shrink();
    }
  }
}

class _ProfileListtile extends StatelessWidget {
  const _ProfileListtile(
      {required this.title,
      this.textColor = Colors.black,
      this.iconColor = Colors.black,
      this.iconLead = Icons.settings});

  final String title;
  final IconData iconLead;
  final Color textColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.horizontalNormal.copyWith(top: 7),
      child: ListTile(
        leading: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white.withOpacity(0.4)),
          child: Icon(
            iconLead,
            color: iconColor,
          ),
        ),
        title: Text(
          textAlign: TextAlign.start,
          title,
          style:
              context.general.textTheme.bodyLarge?.copyWith(color: textColor),
        ),
        trailing: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white.withOpacity(0.1)),
          child: Icon(
            Icons.arrow_forward_ios,
            color: ColorConstants.primaryDark,
          ),
        ),
      ),
    );
  }
}

// * Buy Button of Car Details Page
class _BuyButton extends StatelessWidget {
  const _BuyButton(this.onPressed);

  final VoidCallback onPressed;

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
              borderRadius: context.border.highBorderRadius,
            ),
          ),
        ),
        onPressed: onPressed,
        child: const SizedBox(
          width: 150,
          height: 65,
          child: Center(
            child: Text(
              StringConstants.profileIconText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
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