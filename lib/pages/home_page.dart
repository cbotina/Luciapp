import 'package:flutter/material.dart';
import 'package:luciapp/features/auth/presentation/widgets/constants/widget_keys.dart';
import 'package:luciapp/common/components/app_logotype.dart';
import 'package:luciapp/features/auth/presentation/widgets/components/buttons/logout_icon_button.dart';
import 'package:luciapp/common/components/switch_theme_button.dart';
import 'package:luciapp/features/auth/presentation/widgets/components/user_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key = Keys.homePage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppLogotype(),
        centerTitle: true,
        leading: const LogoutIconButton(),
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
