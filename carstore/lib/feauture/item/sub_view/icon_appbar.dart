import 'package:carstore/product/enums/widget_sizes.dart';
import 'package:flutter/material.dart';

class IconAppBar extends StatelessWidget {
  const IconAppBar(
      {required this.iconColor, required this.iconData, super.key});

  final Color iconColor;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: WidgetSize.iconNormal.value.toDouble(),
      color: iconColor,
      onPressed: () {},
      icon: Icon(iconData),
    );
  }
}
