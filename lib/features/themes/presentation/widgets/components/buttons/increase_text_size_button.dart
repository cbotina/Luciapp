import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/common/components/tappable_container.dart';
import 'package:luciapp/features/font_size/presentation/controllers/font_size_controller.dart';
import 'package:luciapp/features/themes/presentation/widgets/constants/strings.dart';

class IncreaseTextSizeButton extends ConsumerWidget {
  const IncreaseTextSizeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TappableContainer(
      minHeight: 145,
      onPressed: ref.read(fontSizeControllerProvider.notifier).increaseFontSize,
      splashColor: Theme.of(context).colorScheme.primary.withOpacity(.5),
      child: Column(
        children: [
          Icon(
            Icons.text_increase,
            size: 70,
            color: Theme.of(context).colorScheme.primary,
          ),
          Text(
            Strings.increaseFontSize,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
