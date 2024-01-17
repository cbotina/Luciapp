import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:luciapp/common/components/tappable_container.dart';
import 'package:luciapp/features/themes/presentation/widgets/constants/strings.dart';

class DarkModeButton extends StatelessWidget {
  const DarkModeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TappableContainer(
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
                  Icons.sunny,
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
              Strings.darkMode,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
