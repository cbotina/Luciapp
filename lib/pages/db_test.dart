import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/themes/data/repositories/sqlite_theme_repository.dart';
import 'package:luciapp/features/themes/domain/models/theme_settings.dart';
import 'package:luciapp/main.dart';

class Test extends ConsumerWidget {
  Test({super.key});

  final themeRepository = SqLiteThemeRepository();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allUserSettings = ref.watch(getAllSettingsProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              allUserSettings.when(
                data: (data) {
                  return data.toString();
                },
                error: (error, stackTrace) => stackTrace.toString(),
                loading: () => 'loading',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                // ref
                //     .read(themeRepositoryProvider)
                //     .createUserThemeSettings(ThemeSettings.initial('1234'));
                // ref.read(themeRepositoryProvider).updateUserThemeSettings(
                //       ThemeSettings(
                //           userId: '1234',
                //           isDarkModeEnabled: false,
                //           isHCModeEnabled: false),
                //     );

                // final userSettings = await ref
                //     .read(themeRepositoryProvider)
                //     .updateUserThemeSettings(
                //       ThemeSettings(
                //           userId: '1234',
                //           isDarkModeEnabled: false,
                //           isHCModeEnabled: false),
                //     );

                // ref
                //     .read(themeRepositoryProvider)
                //     .deleteUserThemeSettings('2fRyV0irg5XQCRMqVhzDRbL2Lqr1');

                ref.invalidate(getAllSettingsProvider);
              },
              child: const Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }
}

final getAllSettingsProvider = FutureProvider<List<ThemeSettings>>((ref) async {
  return ref.read(themeRepositoryProvider).getAllUsersThemeSettings();
});
