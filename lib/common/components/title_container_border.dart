import 'package:flutter/material.dart';

class TitleContainerBorder extends StatelessWidget {
  final AlignmentGeometry alignment;
  const TitleContainerBorder({
    super.key,
    required this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: alignment,
          child: Container(
            height: MediaQuery.of(context).size.height * .05,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
        ),
        Align(
          alignment: alignment,
          child: Container(
            margin: const EdgeInsets.only(top: 2),
            height: MediaQuery.of(context).size.height * .05,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.only(
                topLeft: alignment == Alignment.topLeft
                    ? const Radius.circular(40)
                    : Radius.zero,
                topRight: alignment == Alignment.topRight
                    ? const Radius.circular(40)
                    : Radius.zero,
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor,
                  blurRadius: 0,
                  spreadRadius: 0,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
