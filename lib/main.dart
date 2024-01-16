import 'package:flutter/material.dart';
import 'package:luciapp/pages/auth_page.dart';
import 'package:luciapp/pages/home_page.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      theme: lightTheme,
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
            child: isLoggedIn ? const HomePage() : const AuthPage(),
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
