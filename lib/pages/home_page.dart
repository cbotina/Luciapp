import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/common/keys/widget_keys.dart';
import 'package:luciapp/features/auth/presentation/widgets/components/app_logotype.dart';
import 'package:luciapp/features/auth/presentation/widgets/components/buttons/logout_button.dart';
import 'package:luciapp/features/auth/presentation/widgets/components/buttons/switch_theme_button.dart';
import 'package:luciapp/features/auth/presentation/widgets/components/user_container.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key = const ValueKey(Keys.homePage)});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const AppLogotype(),
        centerTitle: true,
        leading: const LogoutButton(),
        actions: const [SwitchThemeButton()],
      ),
      body: ListView(
        children: const [
          UserContainer(),
        ],
      ),
    );
  }
}
