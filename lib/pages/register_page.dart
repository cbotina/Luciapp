import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/domain/enums/gender.dart';
import 'package:luciapp/features/auth/domain/models/user.dart';
import 'package:luciapp/features/auth/presentation/controllers/auth_controller.dart';
import 'package:luciapp/main.dart';

class RegisterPage extends StatefulHookConsumerWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  Gender? _selectedGender;

  @override
  Widget build(BuildContext context) {
// solo providers especificos
    final username = ref.read(authRepositoryProvider).displayName;
    final userId = ref.read(authRepositoryProvider).userId;
    final nameController = useTextEditingController();
    final ageController = useTextEditingController();

    nameController.text = username;

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
          ),
        ),
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black.withOpacity(.5),
        ),
        Card(
          // decoration: BoxDecoration(
          //   color: Theme.of(context).colorScheme.surface,
          // ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: Colors.white.withOpacity(.85),
          //
          child: Container(
            width: MediaQuery.of(context).size.width * .8,
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/imagotype_light.png',
                  width: 250,
                  fit: BoxFit.fitWidth,
                ),
                Text(
                  "Aprende sin límites",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 35,
                ),
                OutlinedTextField(
                  label: "Nombre",
                  controller: nameController,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 100,
                      child: OutlinedTextField(
                        label: "Edad",
                        isNumberField: true,
                        controller: ageController,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    DropdownMenu<Gender>(
                      inputDecorationTheme: InputDecorationTheme(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        outlineBorder: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        activeIndicatorBorder: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        ),
                      ),
                      width: 100,
                      menuStyle: MenuStyle(
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      label: const Text("Género"),
                      onSelected: (Gender? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                      dropdownMenuEntries:
                          Gender.values.map<DropdownMenuEntry<Gender>>(
                        (Gender value) {
                          return DropdownMenuEntry<Gender>(
                            value: value,
                            label: value.toString(),
                          );
                        },
                      ).toList(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final User user = User(
                      name: nameController.text,
                      age: int.parse(ageController.text),
                      gender: _selectedGender ?? Gender.male,
                      userId: userId ?? "no",
                    );

                    // llamar a controller

                    await ref
                        .read(authControllerProvider.notifier)
                        .register(user);
                  },
                  child: const Text("Register"),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref.read(authControllerProvider.notifier).logOut();
                  },
                  child: const Text("Salir"),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
