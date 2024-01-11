import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SwitchThemeButton extends ConsumerStatefulWidget {
  const SwitchThemeButton({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SwitchThemeButtonState();
}

class _SwitchThemeButtonState extends ConsumerState<SwitchThemeButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.sunny),
      onPressed: () {},
    );
  }
}
