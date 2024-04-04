import 'package:flutter/material.dart';
import 'package:luciapp/features/themes/presentation/widgets/constants/strings.dart';

class AccessibilityPageTitle extends StatelessWidget {
  const AccessibilityPageTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                Strings.settings,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.accessibility,
                size: 30,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            Strings.setYourPreferences,
            style: Theme.of(context).textTheme.titleMedium,
          )
        ],
      ),
    );
  }
}
