import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class SubtitleText extends StatelessWidget {
  const SubtitleText({required this.subtitle, required this.color, super.key});

  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle,
      style: context.general.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 15,
        color: color,
      ),
    );
  }
}
