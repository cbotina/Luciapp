import 'package:flutter/material.dart';
import 'package:luciapp/features/auth/presentation/widgets/components/buttons/facebook_button.dart';
import 'package:luciapp/features/auth/presentation/widgets/components/buttons/google_button.dart';
import 'package:luciapp/common/components/text_divider.dart';
import 'package:luciapp/features/auth/presentation/widgets/constants/strings.dart';

class LoginButtons extends StatelessWidget {
  const LoginButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 30),
        TextDivider(Strings.welcome),
        SizedBox(height: 30),
        GoogleButton(),
        SizedBox(height: 10),
        FacebookButton(),
      ],
    );
  }
}
