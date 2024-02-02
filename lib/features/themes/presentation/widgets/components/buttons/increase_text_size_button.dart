import 'package:flutter/material.dart';
import 'package:luciapp/common/components/tappable_container.dart';
import 'package:luciapp/features/themes/presentation/widgets/constants/strings.dart';

class IncreaseTextSizeButton extends StatelessWidget {
  const IncreaseTextSizeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TappableContainer(
      minHeight: 145,
      onPressed: () {},
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
