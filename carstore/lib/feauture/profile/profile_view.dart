import 'package:carstore/feauture/auth/network/firebase_auth.dart';
import 'package:carstore/feauture/home/navigation_menu.dart';
import 'package:carstore/product/constants/color_constants.dart';
import 'package:carstore/product/constants/string_constants.dart';
import 'package:carstore/product/widget/app_bar/custom_appbar.dart';
import 'package:carstore/product/widget/text/subtitle_text.dart';
import 'package:carstore/product/widget/text/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuthClass authClass = FirebaseAuthClass();
    return Scaffold(
        appBar: CustomAppBar(StringConstants.profilePageTitle,
            preferredSize: Size.fromHeight(kToolbarHeight),
            onPressed: () => context.route.navigateToPage(NavigationMenu()),
            child: const SizedBox.shrink()),
        body: Padding(
          padding: context.padding.onlyTopNormal,
          child: Column(
            children: [
              SizedBox(
                  width: 150,
                  height: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child:
                        Image(image: NetworkImage('https://picsum.photos/200')),
                  )),
              SizedBox(
                height: 10,
              ),
              TitleText(title: 'Yunus', color: ColorConstants.primaryDark),
              SizedBox(
                height: 5,
              ),
              SubtitleText(
                  subtitle: 'Balkayunus', color: ColorConstants.primaryDark),
              SizedBox(
                height: 20,
              ),
              _BuyButton(),
              Container(
                height: 40, // Çizgi yüksekliği
                color: Colors.transparent, // Çizgi rengi
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
                  authClass.signOutUser();
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
              borderRadius: context.border.highBorderRadius,
            ),
          ),
        ),
        onPressed: () {},
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
