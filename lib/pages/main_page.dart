import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/common/constants/widget_keys.dart';
import 'package:luciapp/features/font_size/presentation/controllers/font_size_controller.dart';
import 'package:luciapp/pages/tabs/accessibility_page.dart';
import 'package:luciapp/pages/tabs/courses_page.dart';
import 'package:luciapp/pages/tabs/games_tab.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key = Keys.mainPage});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late PageController _controller;
  int _selectedPage = 0;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _controller,
            children: const [
              CoursesPage(),
              // GamesPage(),
              AccessibilityPage(),
            ],
            onPageChanged: (index) {
              setState(() {
                _selectedPage = index;
              });
            },
          ),
        ),
        Consumer(
          builder: (context, ref, child) {
            final sf = ref.watch(fontSizeControllerProvider).value!.scaleFactor;
            return BottomNavigationBar(
              currentIndex: _selectedPage,
              selectedItemColor: Theme.of(context).colorScheme.primary,
              showUnselectedLabels: false,
              showSelectedLabels: false,
              iconSize: 25 * sf,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Inicio',
                ),
                // BottomNavigationBarItem(
                //   icon: Icon(Icons.videogame_asset),
                //   label: 'Juegos',
                // ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.accessibility),
                  label: 'Accesibilidad',
                ),
              ],
              onTap: (index) {
                setState(() {
                  _controller.animateToPage(index,
                      duration: Durations.medium1, curve: Curves.easeIn);
                });
              },
            );
          },
        ),
      ],
    );
  }
}
