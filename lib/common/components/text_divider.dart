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
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 200,
          ),
          child: Text(
            text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: foregroundColor),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Divider(color: foregroundColor),
        ),
      ],
    );
  }
}
