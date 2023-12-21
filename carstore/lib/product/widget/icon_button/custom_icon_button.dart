import 'package:carstore/product/enums/widget_sizes.dart';
import 'package:flutter/material.dart';

class IconAppBar extends StatelessWidget {
  const IconAppBar({
    required this.onPressed,
    required this.iconColor,
    required this.iconData,
    super.key,
  });

  final Color iconColor;
  final IconData iconData;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: WidgetSize.iconNormal.value,
      color: iconColor,
      onPressed: onPressed,
      icon: Icon(iconData),
    );
  }
}
