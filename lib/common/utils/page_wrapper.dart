import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/font_size/presentation/controllers/font_size_controller.dart';

class PageWrapper extends ConsumerWidget {
  final Widget page;
  const PageWrapper(this.page, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = MediaQuery.of(context);
    final fontSizeState = ref.watch(fontSizeControllerProvider);

    return MediaQuery(
      data: query.copyWith(
        textScaler: TextScaler.linear(
          fontSizeState.when(
            data: (data) {
              ref.read(fontSizeControllerProvider.notifier).refresh();
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
  }
}
