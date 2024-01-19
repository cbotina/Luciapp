import 'package:flutter/material.dart';
import 'package:luciapp/common/components/title_container_border.dart';
import 'package:luciapp/features/themes/presentation/widgets/components/accessibility_buttons.dart';
import 'package:luciapp/features/themes/presentation/widgets/components/titles/accessibility_page_title.dart';

class AccessibilityPage extends StatelessWidget {
  const AccessibilityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .1326,
        title: const AccessibilityPageTitle(),
        scrolledUnderElevation: 0,
      ),
      body: const Stack(
        children: [
          TitleContainerBorder(
            alignment: Alignment.topRight,
          ),
          AccessibilityButtons(),
        ],
      ),
    );
  }
}
