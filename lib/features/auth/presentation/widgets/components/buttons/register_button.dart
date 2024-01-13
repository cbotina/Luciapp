import 'package:flutter/material.dart';
import 'package:luciapp/features/auth/presentation/widgets/constants/strings.dart';
import 'package:luciapp/features/auth/presentation/widgets/constants/widget_keys.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback onPressed;
  const RegisterButton({
    super.key = Keys.registerButton,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: Keys.registerButton,
      onPressed: onPressed,
      child: const Text(Strings.createAccount),
    );
  }
}
