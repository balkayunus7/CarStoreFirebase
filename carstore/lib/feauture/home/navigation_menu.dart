import 'package:carstore/feauture/home/home_view.dart';
import 'package:carstore/feauture/profile/profile_view.dart';
import 'package:carstore/feauture/save/saved_view.dart';
import 'package:carstore/product/constants/color_constants.dart';
import 'package:carstore/product/enums/widget_sizes.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kartal/kartal.dart';

import '../../product/constants/string_constants.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int currentIndex = 0;
  final List _pages = [
    const HomeView(),
    const SavedPage(),
    const ProfileView()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: ColorConstants.primaryDark,
        child: Padding(
          padding: WidgetSizeConstants.navigationPadding,
          child: GNav(
            selectedIndex: currentIndex,
            gap: 8,
            backgroundColor: ColorConstants.primaryDark,
            color: ColorConstants.primaryWhite,
            activeColor: ColorConstants.primaryWhite,
            tabBackgroundColor: Colors.grey.shade800,
            padding: context.padding.normal,
            onTabChange: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            tabs: [
              GButton(
                icon: Icons.home,
                text: StringConstants.navigationMenuHome,
              ),
              GButton(
                icon: Icons.save,
                text: StringConstants.navigationMenuSaved,
              ),
              GButton(
                icon: Icons.person,
                text: StringConstants.navigationMenuProfile,
              ),
            ],
          ),
        ),
      ),
      body: _pages[currentIndex],
    );
  }
}
