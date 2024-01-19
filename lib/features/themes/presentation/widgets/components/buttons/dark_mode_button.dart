import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/common/components/tappable_container.dart';
import 'package:luciapp/features/themes/presentation/controllers/theme_controller.dart';
import 'package:luciapp/features/themes/presentation/widgets/constants/strings.dart';

class DarkModeButton extends ConsumerWidget {
  const DarkModeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: TappableContainer(
        minHeight: 145,
        onPressed: ref.read(themeControllerProvider.notifier).toggleDarkMode,
        splashColor: Theme.of(context).colorScheme.primary.withOpacity(.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.nightlight_round,
                  size: 50,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  width: 10,
                ),
                Switch(
                  value: ref
                      .watch(themeControllerProvider)
                      .value!
                      .isDarkModeEnabled,
                  onChanged: null,
                  thumbColor: const MaterialStatePropertyAll(Colors.white),
                  inactiveTrackColor: Colors.grey,
                  activeTrackColor: Theme.of(context).colorScheme.primary,
                  trackOutlineWidth: const MaterialStatePropertyAll(0),
                  trackOutlineColor:
                      const MaterialStatePropertyAll(Colors.transparent),
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
