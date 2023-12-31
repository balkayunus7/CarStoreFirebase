import 'dart:io';
import 'package:carstore/feauture/auth/login_view.dart';
import 'package:carstore/feauture/auth/network/firebase_auth.dart';
import 'package:carstore/feauture/home/navigation_menu.dart';
import 'package:carstore/feauture/profile/providers/profile_provider.dart';
import 'package:carstore/feauture/profile/sub/settings_page.dart';
import 'package:carstore/feauture/profile/sub/user_management.dart';
import 'package:carstore/feauture/profile/providers/theme_provider.dart';
import 'package:carstore/product/constants/color_constants.dart';
import 'package:carstore/product/constants/string_constants.dart';
import 'package:carstore/product/enums/widget_sizes.dart';
import 'package:carstore/product/widget/icon_button/custom_icon_button.dart';
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

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  void initState() {
    super.initState();
    ref.read(_profilProvider.notifier).getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(_profilProvider).currentUser;
    final appThemeState = ref.read(appThemeStateNotifier);
    final appStateColor =
        ref.watch(appThemeStateNotifier).isDarkModeEnabled == false
            ? ColorConstants.primaryDark
            : ColorConstants.primaryWhite;
    final FirebaseAuthClass fAuth = FirebaseAuthClass();
    if (currentUser != null) {
      return Scaffold(
          appBar: _CustomAppBar(
              StringConstants.profilePageTitle,
              appThemeState.isDarkModeEnabled == false
                  ? ColorConstants.primaryDark
                  : ColorConstants.primaryWhite,
              preferredSize: const Size.fromHeight(kToolbarHeight),
              onPressed: () =>
                  context.route.navigateToPage(const NavigationMenu()),
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
                  height: WidgetSize.sizedBoxLow.value,
                ),
                TitleText(
                  title: currentUser.name ?? '',
                  color: appStateColor,
                ),
                SizedBox(
                  height: WidgetSize.sizedBoxLow.value,
                ),
                SubtitleText(
                    subtitle: currentUser.email ?? '', color: appStateColor),
                SizedBox(
                  height: WidgetSize.sizedBoxNormal.value,
                ),
                _BuyButton(() {
                  context.route.navigateToPage(const UserManagementPage());
                }),
                Container(
                  height: WidgetSize.sizedBoxBig.value,
                  color: Colors.transparent,
                ),
                GestureDetector(
                    onTap: () {
                      context.route.navigateToPage(SettingsPage());
                    },
                    child: const _ProfileListtile(
                        title: StringConstants.changePassword)),
                GestureDetector(
                  onTap: () {
                    fAuth.signOutUser();
                    context.route.navigateToPage(LoginPage());
                  },
                  child: const _ProfileListtile(
                    title: StringConstants.logoutText,
                    iconLead: Icons.logout,
                    textColor: ColorConstants.primaryDark,
                    iconColor: ColorConstants.primaryRed,
                  ),
                ),
              ],
            ),
          ));
    } else {
      return const SizedBox.shrink();
    }
  }
}

class ThemeIcon extends ConsumerWidget {
  const ThemeIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeState = ref.watch(appThemeStateNotifier);
    return IconButton(
      icon: Icon(
        appThemeState.isDarkModeEnabled
            ? Icons.wb_sunny_outlined
            : Icons.nightlight_outlined,
        color: appThemeState.isDarkModeEnabled
            ? ColorConstants.primaryWhite
            : ColorConstants.primaryDark,
      ),
      onPressed: () {
        if (appThemeState.isDarkModeEnabled) {
          appThemeState.setLighttheme();
        } else {
          appThemeState.setDarkTheme();
        }
      },
    );
  }
}

class _ProfileListtile extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeState = ref.watch(appThemeStateNotifier);
    return Padding(
      padding: context.padding.horizontalNormal.copyWith(top: 7),
      child: ListTile(
        leading: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              borderRadius: WidgetSizeConstants.borderRadiusBig,
              color: appThemeState.isDarkModeEnabled == false
                  ? Colors.grey.shade300
                  : ColorConstants.primaryWhite),
          child: Icon(
            iconLead,
            color: iconColor,
          ),
        ),
        title: Text(
          textAlign: TextAlign.start,
          title,
          style: context.general.textTheme.bodyLarge?.copyWith(
              color: appThemeState.isDarkModeEnabled == false
                  ? ColorConstants.primaryDark
                  : ColorConstants.primaryWhite),
        ),
        trailing: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              borderRadius: WidgetSizeConstants.borderRadiusBig,
              color: Colors.white.withOpacity(0.1)),
          child: Icon(
            Icons.arrow_forward_ios,
            color: appThemeState.isDarkModeEnabled == false
                ? ColorConstants.primaryDark
                : ColorConstants.primaryWhite,
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

class _CustomAppBar extends PreferredSize {
  const _CustomAppBar(
    this.title,
    this.iconColor, {
    required super.preferredSize,
    required super.child,
    required this.onPressed,
  });

  final String title;
  final VoidCallback onPressed;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconAppBar(
        iconColor: iconColor,
        iconData: Icons.arrow_back,
        onPressed: onPressed,
      ),
      centerTitle: true,
      title: TitleText(
        title: title,
        color: ColorConstants.primaryOrange,
      ),
      actions: [
        const ThemeIcon(),
        SizedBox(
          width: WidgetSize.sizedBoxNormal.value,
        )
      ],
      backgroundColor: Colors.transparent,
    );
  }
}
