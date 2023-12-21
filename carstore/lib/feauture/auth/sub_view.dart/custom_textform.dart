import 'package:carstore/product/constants/color_constants.dart';
import 'package:carstore/product/enums/widget_sizes.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.icon});

  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(
            icon,
            color: ColorConstants.primaryOrange,
          ),
          hintStyle: context.general.textTheme.bodyMedium,
          border: OutlineInputBorder(
            borderRadius: WidgetSizeConstants.borderRadiusNormal,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: WidgetSizeConstants.borderRadiusNormal,
            borderSide: BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
          enabled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: WidgetSizeConstants.borderRadiusNormal,
            borderSide: BorderSide(
              color: ColorConstants.primaryOrange,
              width: 3,
            ),
          )),
    );
  }
}
