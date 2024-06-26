import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/font_size/presentation/controllers/font_size_controller.dart';

class AccessibilityWrapper extends ConsumerWidget {
  final Widget page;
  const AccessibilityWrapper(this.page, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = MediaQuery.of(context);

    return Consumer(
      builder: (context, ref, child) {
        final fontSizeState = ref.watch(fontSizeControllerProvider);
        return MediaQuery(
          data: query.copyWith(
            textScaler: TextScaler.linear(
              fontSizeState.when(
                data: (data) {
                  return data.scaleFactor;
                },
                error: (error, stackTrace) {
                  return 1;
                },
                loading: () {
                  return 1;
                },
              ),
            ),
          ),
          child: page,
        );
      },
    );
  }
}
