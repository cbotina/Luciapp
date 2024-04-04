import 'package:flutter/material.dart';

class TappableContainer extends StatelessWidget {
  final Widget? child;
  final VoidCallback onPressed;
  final Color? splashColor;
  final double? minHeight;
  final Color? borderColor;
  final Color? backgroundColor;
  final double borderRadius;
  final double padding;
  const TappableContainer({
    super.key,
    this.child,
    required this.onPressed,
    this.splashColor,
    this.minHeight,
    this.borderRadius = 15,
    this.padding = 20,
    this.borderColor,
    this.backgroundColor,
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
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor ??
                  Theme.of(context).colorScheme.outline, // transparente
              width: 3,
            ),
            color: backgroundColor ?? Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(borderRadius),
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
