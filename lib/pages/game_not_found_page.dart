import 'package:flutter/material.dart';
import 'package:luciapp/common/utils/page_wrapper.dart';

class GameNotFoundPage extends StatelessWidget {
  const GameNotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AccessibilityWrapper(
      Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.info_outline,
                color: Theme.of(context).colorScheme.primary,
                size: 100,
              ),
              const Text(
                'Este contenido está en desarrollo',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const Text(
                "Pronto estara disponible",
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Entendido"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
