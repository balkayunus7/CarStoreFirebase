import 'package:carstore/product/constants/color_constants.dart';
import 'package:carstore/product/widget/icon_button/custom_icon_button.dart';
import 'package:carstore/product/widget/text/title_text.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends PreferredSize {
  CustomAppBar(
    this.title, {
    required this.iconColor,
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
      backgroundColor: Colors.transparent,
    );
  }
}
