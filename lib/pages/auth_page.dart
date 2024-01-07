import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/domain/enums/gender.dart';
import 'package:luciapp/features/auth/presentation/widgets/components/enum_dropdown_menu.dart';
import 'package:luciapp/features/auth/presentation/widgets/components/outlined_text_field.dart';
import 'package:luciapp/features/auth/presentation/widgets/components/text_divider.dart';

class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(
            'assets/images/background.jpg',
            fit: BoxFit.fitHeight,
            alignment: Alignment.center,
            opacity: const AlwaysStoppedAnimation(.5),
          ),
        ),
        Card(
          child: Container(
            width: MediaQuery.of(context).size.width * .85,
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'assets/images/imagotype_slogan_light.png',
                  height: 90,
                  fit: BoxFit.fitHeight,
                ),
                const SizedBox(height: 30),
                // abstract
                const TextDivider(' Ingresa tus datos '),
                const SizedBox(
                  height: 30,
                ),
                Wrap(
                  runSpacing: 15,
                  children: [
                    const OutlinedTextField(
                      label: 'Nombre',
                      controller: null,
                    ),
                    const OutlinedTextField(
                      label: 'Edad',
                      isNumberField: true,
                      controller: null,
                    ),
                    EnumDropdownMenu<Gender>(
                      label: 'Género',
                      onSelected: (value) {},
                      values: Gender.values,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 45,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Crear Cuenta"),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
