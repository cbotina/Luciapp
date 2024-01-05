import 'dart:developer';
import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/common/dialogs/dialog_template.dart';
import 'package:luciapp/common/theme/app_theme.dart';
import 'package:luciapp/features/auth/domain/enums/auth_result.dart';
import 'package:luciapp/features/auth/domain/models/auth_state.dart';
import 'package:luciapp/features/auth/presentation/state/auth_state_provider.dart';
import 'package:luciapp/features/auth/presentation/widgets/dialogs/create_account_dialog.dart';
import 'package:luciapp/firebase_options.dart';

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
            final AuthResult? authResult = ref.watch(authStateProvider).result;
            if (authResult == null) {
              return const LoginPage();
            } else {
              switch (authResult) {
                case AuthResult.success:
                  return const HomePage();

                case AuthResult.aborted:
                case AuthResult.failure:
                  return const LoginPage();

                case AuthResult.registering:
                  return const Other();
              }
            }
          },
        ),
      ),
    );
  }
}

class Other extends StatelessWidget {
  const Other({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Bienvenido"),
      ),
    );
  }
}

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            ElevatedButton(
              onPressed: () {
                ref.read(authStateProvider.notifier).loginWithGoogle();
              },
              child: const Text("Login google"),
            ),
          ],
        ),
      ),
    );
  }
}

class OutlinedTextField extends StatelessWidget {
  String? initialValue;
  String label;
  bool isNumberField;

  OutlinedTextField({
    super.key,
    required this.label,
    this.isNumberField = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
