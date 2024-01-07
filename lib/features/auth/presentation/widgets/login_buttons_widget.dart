import 'package:flutter/material.dart';
import 'package:luciapp/features/auth/presentation/widgets/components/facebook_button.dart';
import 'package:luciapp/features/auth/presentation/widgets/components/google_button.dart';

class LoginButtonsWidget extends StatelessWidget {
  const LoginButtonsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GoogleButton(
          onPressed: () {},
        ),
        const SizedBox(
          height: 10,
        ),
        FacebookButton(
          onPressed: () {},
        ),
      ],
    );
  }
}
