import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/domain/enums/gender.dart';
import 'package:luciapp/features/auth/domain/models/user.dart';
import 'package:luciapp/features/auth/presentation/controllers/auth_controller.dart';
import 'package:luciapp/features/auth/presentation/widgets/components/enum_dropdown_menu.dart';
import 'package:luciapp/features/auth/presentation/widgets/components/outlined_text_field.dart';
import 'package:luciapp/features/auth/presentation/widgets/components/text_divider.dart';
import 'package:luciapp/main.dart';

class RegisterForm extends StatefulHookConsumerWidget {
  const RegisterForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  Gender? _selectedGender;
  bool isRegisterButtonEnabled = false;
  late TextEditingController _nameController;
  late TextEditingController _ageController;

  void validateFields() {
    isRegisterButtonEnabled = _nameController.text.isNotEmpty &&
        _ageController.text.isNotEmpty &&
        _selectedGender != null;
  }

  @override
  void initState() {
    _ageController = TextEditingController()..addListener(validateFields);
    _nameController = TextEditingController()..addListener(validateFields);
    _nameController.text = ref.read(authRepositoryProvider).displayName;
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.read(authRepositoryProvider).userId;

    return Column(
      children: [
        const SizedBox(height: 30),
        const TextDivider(' Ingresa tus datos '),
        const SizedBox(height: 30),
        Wrap(
          runSpacing: 15,
          children: [
            OutlinedTextField(
              label: 'Nombre',
              controller: _nameController,
            ),
            OutlinedTextField(
              label: 'Edad',
              isNumberField: true,
              controller: _ageController,
            ),
            EnumDropdownMenu<Gender>(
              label: 'Género',
              onSelected: (value) {
                setState(() {
                  _selectedGender = value;
                  validateFields();
                });
              },
              values: Gender.values,
            ),
          ],
        ),
        const SizedBox(
          height: 45,
        ),
        ElevatedButton(
          onPressed: isRegisterButtonEnabled
              ? () async {
                  final User user = User(
                    name: _nameController.text,
                    age: int.parse(_ageController.text),
                    gender: _selectedGender ?? Gender.nonBinary,
                    userId: userId ?? "",
                  );

                  await ref
                      .read(authControllerProvider.notifier)
                      .register(user);
                }
              : null,
          child: const Text("Crear Cuenta"),
        ),
      ],
    );
  }
}
