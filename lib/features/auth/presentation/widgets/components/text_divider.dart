import 'package:flutter/material.dart';

class TextDivider extends StatelessWidget {
  final String text;
  const TextDivider(
    this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey.shade700,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            color: Colors.grey.shade700,
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }
}
