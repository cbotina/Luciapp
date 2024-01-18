import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/common/components/tappable_container.dart';
import 'package:luciapp/features/themes/data/providers/is_dark_mode_enabled_provider.dart';
import 'package:luciapp/features/themes/domain/enums/theme_mode.dart';
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
                  Icons.sunny,
                  size: 50,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  width: 10,
                ),
                CupertinoSwitch(
                  value: ref
                      .watch(themeControllerProvider)
                      .value!
                      .isDarkModeEnabled,
                  onChanged: null,
                  activeColor: Theme.of(context).colorScheme.primary,
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
