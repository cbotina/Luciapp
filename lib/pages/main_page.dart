import 'package:flutter/material.dart';
import 'package:luciapp/pages/tabs/accessibility_page.dart';
import 'package:luciapp/pages/tabs/courses_page.dart';
import 'package:luciapp/pages/tabs/games_tab.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: const [
        CoursesPage(),
        GamesPage(),
        AccessibilityPage(),
      ],
    );
  }
}
