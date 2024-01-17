import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luciapp/common/components/tappable_container.dart';
import 'package:luciapp/features/themes/presentation/widgets/constants/strings.dart';

class HighContrastButton extends StatelessWidget {
  const HighContrastButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TappableContainer(
      minHeight: 145,
      onPressed: () {},
      splashColor: Theme.of(context).colorScheme.primary.withOpacity(.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.contrast,
                size: 50,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(
                width: 10,
              ),
              const CupertinoSwitch(
                value: false,
                onChanged: null,
              ),
            ],
          ),
          Text(
            Strings.highContrastMode,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
