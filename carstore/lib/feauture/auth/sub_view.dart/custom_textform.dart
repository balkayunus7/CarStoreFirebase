import 'package:carstore/product/constants/color_constants.dart';
import 'package:carstore/product/enums/widget_sizes.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomTextfield extends StatelessWidget {
   const CustomTextfield(
      {super.key,
      required this.iconFirst,
      required this.controller,
      required this.hintText,
      });

  final TextEditingController controller;
  final String hintText;
  final IconData iconFirst;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: false,
      decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(
            iconFirst,
            color: ColorConstants.primaryOrange,
          ),
          hintStyle: context.general.textTheme.bodyMedium,
          border: OutlineInputBorder(
            borderRadius: WidgetSizeConstants.borderRadiusNormal,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: WidgetSizeConstants.borderRadiusNormal,
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
          
          enabled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: WidgetSizeConstants.borderRadiusNormal,
            borderSide: const BorderSide(
              color: ColorConstants.primaryOrange,
              width: 3,
            ),
          )),
    );
  }
}


class CustomTextfieldPassword extends StatefulWidget {
   const CustomTextfieldPassword(
      {super.key,
      required this.iconFirst,
      required this.controller,
      required this.hintText,
      });

  final TextEditingController controller;
  final String hintText;
  final IconData iconFirst;

  @override
  State<CustomTextfieldPassword> createState() => _CustomTextfieldPasswordState();
}

class _CustomTextfieldPasswordState extends State<CustomTextfieldPassword> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: Icon(
            widget.iconFirst,
            color: ColorConstants.primaryOrange,
          ),
          hintStyle: context.general.textTheme.bodyMedium,
          border: OutlineInputBorder(
            borderRadius: WidgetSizeConstants.borderRadiusNormal,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: WidgetSizeConstants.borderRadiusNormal,
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText=!_obscureText;
              });
            },
            child: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: ColorConstants.primaryOrange,
            ),
          ),
          enabled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: WidgetSizeConstants.borderRadiusNormal,
            borderSide: const BorderSide(
              color: ColorConstants.primaryOrange,
              width: 3,
            ),
          )),
    );
  }
}