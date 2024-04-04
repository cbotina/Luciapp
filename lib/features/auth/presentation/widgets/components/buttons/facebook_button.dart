import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/presentation/widgets/constants/strings.dart';
import 'package:luciapp/features/auth/presentation/controllers/auth_controller.dart';
import 'package:luciapp/features/auth/presentation/widgets/constants/widget_keys.dart';

class FacebookButton extends ConsumerWidget {
  const FacebookButton({super.key = Keys.facebookButton});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      splashColor: Colors.blue.shade100,
      onTap: ref.read(authControllerProvider.notifier).loginWithFacebook,
      child: Ink(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiaryContainer,
          border: Border.all(
            color: Theme.of(context).colorScheme.outline, // transparente
            width: 3,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              blurRadius: 3,
              spreadRadius: 0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(
              Icons.facebook,
              size: 38,
              color: Theme.of(context).colorScheme.onTertiaryContainer,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                Strings.continueWithFacebook,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onTertiaryContainer,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
