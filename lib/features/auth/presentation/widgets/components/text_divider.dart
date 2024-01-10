import 'package:flutter/material.dart';

class TextDivider extends StatelessWidget {
  final String text;
  const TextDivider(
    this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final foregroundColor = Theme.of(context).colorScheme.onPrimaryContainer;
    return Row(
      children: [
        Expanded(
          child: Divider(color: foregroundColor),
        ),
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: foregroundColor),
        ),
        Expanded(
          child: Divider(color: foregroundColor),
        ),
      ],
    );
  }
}
