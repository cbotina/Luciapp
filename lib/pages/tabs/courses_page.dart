import 'package:flutter/material.dart';
import 'package:luciapp/common/components/about_icon_button.dart';
import 'package:luciapp/features/auth/presentation/widgets/constants/widget_keys.dart';
import 'package:luciapp/common/components/app_logotype.dart';
import 'package:luciapp/features/auth/presentation/widgets/components/buttons/logout_icon_button.dart';
import 'package:luciapp/features/courses/presentation/widgets/course_list.dart';
import 'package:luciapp/features/themes/presentation/widgets/components/buttons/dark_mode_icon_button.dart';
import 'package:luciapp/features/auth/presentation/widgets/components/user_container.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key = Keys.homePage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppLogotype(),
        centerTitle: true,
        leading: const LogoutIconButton(),
        actions: const [
          AboutIconButton(),
          DarkModeIconButton(),
        ],
      ),
      body: ListView(
        children: const [
          UserContainer(),
          CourseListWidget(),
        ],
      ),
    );
  }
}
