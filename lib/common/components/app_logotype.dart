import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppLogotype extends ConsumerWidget {
  const AppLogotype({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Image.asset(
      'assets/images/imagotype_light.png',
      height: 30,
    );
  }
}
