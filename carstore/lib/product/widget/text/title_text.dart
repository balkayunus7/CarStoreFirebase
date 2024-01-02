import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class TitleText extends StatelessWidget {
  const TitleText({required this.title, required this.color, super.key});

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.general.textTheme.titleLarge
          ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20, color: color),
    );
  }
}
