import 'package:flutter/material.dart';

class CreateAccountDialogBody extends StatelessWidget {
  const CreateAccountDialogBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/imagotype_light.png',
            width: 200,
            fit: BoxFit.fitWidth,
          ),
          Text(
            "Aprende sin limites",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
          const Text(
            'Ingresa tus datos...',
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
