import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/common/keys/widget_keys.dart';
import 'package:luciapp/common/loading/loading_screen.dart';
import 'package:luciapp/common/providers/is_loading_provider.dart';
import 'package:luciapp/common/theme/app_theme.dart';
import 'package:luciapp/features/auth/data/auth_repository.dart';
import 'package:luciapp/features/auth/data/firebase_auth_repository.dart';
import 'package:luciapp/features/auth/data/firebase_users_repository.dart';
import 'package:luciapp/features/auth/data/providers/auth_result_provider.dart';
import 'package:luciapp/features/auth/data/users_repository.dart';
import 'package:luciapp/features/auth/domain/enums/auth_result.dart';
import 'package:luciapp/firebase_options.dart';
import 'package:luciapp/pages/auth_page.dart';
import 'package:luciapp/pages/home_page.dart';
import 'package:luciapp/pages/login_page.dart';

enum AuthServiceType { firebase, mock }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  final AuthServiceType initialAuthServiceType;
  const MyApp({
    super.key,
    this.initialAuthServiceType = AuthServiceType.firebase,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      home: MediaQuery(
        data: query.copyWith(
          textScaler: const TextScaler.linear(1.4),
        ),
        child: Consumer(
          child: const LoginPage(),
          builder: (context, ref, child) {
            ref.listen<bool>(
              isLoadingProvider,
              (_, isLoading) {
                if (isLoading) {
                  LoadingScreen.instance().show(context: context);
                } else {
                  LoadingScreen.instance().hide();
                }
              },
            );

            final AuthResult? authResult = ref.watch(authResultProvider);

            if (authResult == null) {
              return const AuthPage();
            } else {
              switch (authResult) {
                case AuthResult.success:
                  return const HomePage(
                    key: ValueKey(Keys.homePage),
                  );
                default:
                  return const AuthPage();
              }
            }
          },
        ),
      ),
    );
  }
}

// Repositories

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return const FirebaseAuthRepository();
});

final usersRepositoryProvider = Provider<UsersRepository>((ref) {
  return FirebaseUserRepository();
});
