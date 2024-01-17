import 'package:flutter/material.dart';

class TappableContainer extends StatelessWidget {
  final Widget? child;
  final VoidCallback onPressed;
  final Color? splashColor;
  final double? minHeight;
  final double borderRadius;
  const TappableContainer({
    super.key,
    this.child,
    required this.onPressed,
    this.splashColor,
    this.minHeight,
    this.borderRadius = 15,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(borderRadius),
      elevation: 3,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: onPressed,
        splashColor: splashColor,
        child: Ink(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(borderRadius),
            // border: Border.all(color: Colors.black), para HC
          ),
          child: Container(
            constraints: BoxConstraints(
              minHeight: minHeight ?? 0,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
