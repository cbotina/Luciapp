import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:luciapp/common/dialogs/dialog_template.dart';
import 'package:luciapp/common/theme/app_theme.dart';
import 'package:luciapp/features/auth/presentation/dialogs/create_account_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            bool answer = await const CreateAccountDialog()
                .present(context)
                .then((value) => value ?? false);
            log("$answer");
          },
          child: Text(
            "Show dialog",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}
