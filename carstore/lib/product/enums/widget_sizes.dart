import 'package:flutter/material.dart';

enum WidgetSize {
  butttonNormal(56),
  iconNormal(30),
  sizedBoxLow(10),
  sizedBoxNormal(20),
  sizedBoxBig(50),
  paddingAuthTop(180),
  fontSizeNormal(20);


  final double value;

  // ignore: sort_constructors_first
  const WidgetSize(this.value);
}


class WidgetSizeConstants {
 static   BorderRadius get borderRadiusNormal => BorderRadius.circular(10);
 static   BorderRadius get borderRadiusBig => BorderRadius.circular(10);
 static   EdgeInsets get navigationPadding => EdgeInsets.symmetric(horizontal: 15, vertical: 10);
}