import 'package:flutter/material.dart';
import 'package:luciapp/common/components/tappable_container.dart';
import 'package:luciapp/features/themes/presentation/widgets/constants/strings.dart';

class DecreaseTextSizeButton extends StatelessWidget {
  const DecreaseTextSizeButton({
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
            Icons.text_decrease,
            size: 70,
            color: Theme.of(context).primaryColor,
          ),
          Text(
            Strings.decreaseFontSize,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
