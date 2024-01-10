import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/common/keys/widget_keys.dart';
import 'package:luciapp/features/auth/data/providers/is_registering_provider.dart';
import 'package:luciapp/features/auth/presentation/widgets/login_buttons_widget.dart';
import 'package:luciapp/features/auth/presentation/widgets/register_form_widget.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key = const ValueKey(Keys.authPage)});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(
            'assets/images/background.jpg',
            fit: BoxFit.fitHeight,
            alignment: Alignment.center,
            opacity: const AlwaysStoppedAnimation(.5),
          ),
        ),
        Card(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * .9,
                maxWidth: MediaQuery.of(context).size.width * .85),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/imagotype_slogan_light.png',
                      height: 90,
                      fit: BoxFit.fitHeight,
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        final isRegistering = ref.watch(isRegisteringProvider);

                        return isRegistering
                            ? const RegisterForm()
                            : const LoginButtons();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
