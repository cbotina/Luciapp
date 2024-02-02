import 'package:flutter/material.dart';
import 'package:luciapp/common/themes/themes.dart';
import 'package:luciapp/features/themes/data/abstract_repositories/theme_settings_repositor.dart';
import 'package:luciapp/features/themes/data/repositories/sqlite_theme_settings_repository.dart';
import 'package:luciapp/features/themes/presentation/controllers/theme_controller.dart';
import 'package:luciapp/pages/auth_page.dart';
import 'package:luciapp/pages/main_page.dart';
import 'package:luciapp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/common/constants/strings.dart';
import 'package:luciapp/common/themes/light_theme.dart';
import 'package:luciapp/common/loading/loading_screen.dart';
import 'package:luciapp/common/providers/is_loading_provider.dart';
import 'package:luciapp/features/auth/data/providers/is_logged_in_provider.dart';
import 'package:luciapp/features/auth/data/repositories/firebase_auth_repository.dart';
import 'package:luciapp/features/auth/data/abstract_repositories/auth_repository.dart';
import 'package:luciapp/features/auth/data/abstract_repositories/users_repository.dart';
import 'package:luciapp/features/auth/data/repositories/firebase_users_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeMode = ref.watch(themeControllerProvider);

    return MaterialApp(
      title: Strings.appName,
      theme: appThemeMode.when(
        data: (data) {
          ref.read(themeControllerProvider.notifier).refresh();
          return themes[data.appThemeMode];
        },
        error: (error, stackTrace) => lightTheme,
        loading: () => lightTheme,
      ),
      // home: Test(),
      home: Consumer(
        builder: (context, ref, child) {
          final query = MediaQuery.of(context);
          final isLoggedIn = ref.watch(isLoggedInProvider);

          ref.listen<bool>(isLoadingProvider, (_, isLoading) {
            if (isLoading) {
              LoadingScreen.instance().show(context: context);
            } else {
              LoadingScreen.instance().hide();
            }
          });

          return MediaQuery(
            data: query.copyWith(textScaler: const TextScaler.linear(1)),
            child: isLoggedIn ? const MainPage() : const AuthPage(),
          );
        },
      ),
    );
  }
}

// Repositories

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  return const FirebaseAuthRepository();
});

final usersRepositoryProvider = Provider<IUsersRepository>((ref) {
  return const FirebaseUserRepository();
});

final themeRepositoryProvider = Provider<IThemeSettingsReposiroty>((ref) {
  return SqLiteThemeSettingsRepository();
});
