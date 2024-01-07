import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/common/theme/app_theme.dart';
import 'package:luciapp/features/auth/data/auth_repository.dart';
import 'package:luciapp/features/auth/data/firebase_users_repository.dart';
import 'package:luciapp/features/auth/data/users_repository.dart';
import 'package:luciapp/features/auth/domain/enums/auth_result.dart';
import 'package:luciapp/features/auth/presentation/controllers/auth_controller.dart';
import 'package:luciapp/firebase_options.dart';
import 'package:luciapp/pages/home_page.dart';
import 'package:luciapp/pages/login_page.dart';
import 'package:luciapp/pages/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
            final AuthResult? authResult =
                ref.watch(authControllerProvider).result;
            debugPrint(authResult.toString());
            if (authResult == null) {
              return const LoginPage();
            } else {
              switch (authResult) {
                case AuthResult.success:
                  return const HomePage();

                case AuthResult.aborted:
                  return const LoginPage();
                case AuthResult.failure:
                  return const LoginPage();

                case AuthResult.registering:
                  return const RegisterPage();
              }
            }
          },
        ),
      ),
    );
  }
}

class AuxHomePage extends ConsumerWidget {
  const AuxHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ref.read(authControllerProvider.notifier).logOut();
          },
          child: const Text("Logout"),
        ),
      ),
    );
  }
}

class OutlinedTextField extends StatelessWidget {
  String? initialValue;
  String label;
  bool isNumberField;
  TextEditingController controller;

  OutlinedTextField({
    super.key,
    this.initialValue,
    required this.label,
    required this.controller,
    this.isNumberField = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      decoration: InputDecoration(
        label: Text(label),
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      inputFormatters: isNumberField
          ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))]
          : null,
      keyboardType: isNumberField ? TextInputType.number : TextInputType.text,
    );
  }
}

// Repositories

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return const AuthRepository();
});

final usersRepositoryProvider = Provider<UsersRepository>((ref) {
  return FirebaseUserRepository();
});
