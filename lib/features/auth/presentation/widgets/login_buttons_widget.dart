import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/common/keys/widget_keys.dart';
import 'package:luciapp/features/auth/presentation/controllers/auth_controller.dart';
import 'package:luciapp/features/auth/presentation/widgets/components/facebook_button.dart';
import 'package:luciapp/features/auth/presentation/widgets/components/google_button.dart';
import 'package:luciapp/features/auth/presentation/widgets/components/text_divider.dart';

class LoginButtons extends ConsumerWidget {
  const LoginButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const SizedBox(height: 30),
        const TextDivider(' Te damos la bienvenida '),
        const SizedBox(height: 30),
        GoogleButton(
          onPressed: ref.read(authControllerProvider.notifier).loginWithGoogle,
        ),
        const SizedBox(
          height: 10,
        ),
        FacebookButton(
          key: const ValueKey(Keys.facebookButton),
          onPressed:
              ref.read(authControllerProvider.notifier).loginWithFacebook,
        ),
      ],
    );
  }
}
