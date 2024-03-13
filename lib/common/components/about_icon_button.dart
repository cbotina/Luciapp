import 'package:flutter/material.dart';
import 'package:luciapp/common/utils/page_wrapper.dart';
import 'package:luciapp/pages/tabs/info_tab.dart';

class AboutIconButton extends StatelessWidget {
  const AboutIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Información de la aplicación',
      child: ExcludeSemantics(
        child: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: const AboutPage(),
                actions: [
                  AccessibilityWrapper(
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Aceptar"),
                    ),
                  )
                ],
              ),
            );
          },
          icon: const Icon(Icons.info),
        ),
      ),
    );
  }
}
