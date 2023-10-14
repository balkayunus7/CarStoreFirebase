import 'package:carstore/product/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

@immutable
class AppTheme {
  const AppTheme({required this.context});

  final BuildContext context;
  ThemeData get theme => ThemeData.light().copyWith(
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.all(15),
            ),
            textStyle: MaterialStateProperty.all<TextStyle?>(
              context.general.textTheme.bodyLarge,
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
              ColorConstants.primaryOrange,
            ),
            foregroundColor: MaterialStateProperty.all<Color>(
              Colors.white,
            ),
          ),
        ),
      );
}
