import 'package:carstore/product/enums/image_sizes.dart';
import 'package:flutter/material.dart';

enum IconConstants {
  playstore('playstore'),
  logo('logo'),
  ;

  final String value;
  // ignore: sort_constructors_first
  const IconConstants(this.value);

  String get toPng => 'assets/icon/$value.png';
  Image get toImage => Image.asset(
        toPng,
        height: ImageSize.height.value.toDouble(),
      );
}
