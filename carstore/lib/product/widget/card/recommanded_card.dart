import 'package:carstore/product/enums/image_sizes.dart';
import 'package:carstore/product/models/recomanded.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class RecommandedCard extends StatelessWidget {
  const RecommandedCard({
    required this.recommended,
    super.key,
  });

  final Recommended recommended;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.onlyTopLow,
      child: Row(
        children: [
          Image.network(
            recommended.image ?? '',
            width: ImageSize.normal.value.toDouble(),
            height: ImageSize.normal.value.toDouble(),
          ),
          Expanded(
            child: ListTile(
              title: Text(recommended.title ?? ''),
              subtitle: Text(recommended.description ?? ''),
            ),
          ),
        ],
      ),
    );
  }
}
