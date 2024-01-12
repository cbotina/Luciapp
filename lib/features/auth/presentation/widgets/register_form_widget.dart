import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/common/keys/widget_keys.dart';
import 'package:luciapp/common/components/text_divider.dart';
import 'package:luciapp/features/auth/domain/models/user.dart';
import 'package:luciapp/features/auth/domain/enums/gender.dart';
import 'package:luciapp/features/auth/data/providers/user_id_provider.dart';
import 'package:luciapp/features/auth/presentation/widgets/constants/strings.dart';
import 'package:luciapp/features/auth/presentation/controllers/auth_controller.dart';
import 'package:luciapp/features/auth/data/providers/user_display_name_provider.dart';
import 'package:luciapp/features/auth/presentation/widgets/validators/age_validator.dart';
import 'package:luciapp/features/auth/presentation/widgets/validators/name_validator.dart';
import 'package:luciapp/features/auth/presentation/widgets/validators/gender_validator.dart';
import 'package:luciapp/features/auth/presentation/widgets/components/form_fields/enum_dropdown_form_field.dart';
import 'package:luciapp/features/auth/presentation/widgets/components/form_fields/outlined_text_form_field.dart';

class RegisterForm extends StatefulHookConsumerWidget {
  const RegisterForm({super.key = Keys.registerForm});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _ageController;

  Gender? _selectedGender;

  @override
  void initState() {
    _ageController = TextEditingController();
    _nameController = TextEditingController();
    _nameController.text = ref.read(userDisplayNameProvider) ?? "";
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
    final userId = ref.read(userIdProvider);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 30),
          const TextDivider(Strings.enterYourInfo),
          const SizedBox(height: 30),
          Wrap(
            runSpacing: 15,
            children: [
              OutlinedTextFormField(
                key: Keys.nameTextFormField,
                label: Strings.nameLabel,
                controller: _nameController,
                validator: nameValidator,
              ),
              OutlinedTextFormField(
                key: Keys.ageTextFormField,
                label: Strings.ageLabel,
                isNumberField: true,
                controller: _ageController,
                validator: ageValidator,
              ),
              EnumDropdownButtonFormField<Gender>(
                key: Keys.genderDropdownButton,
                label: Strings.genderLabel,
                values: Gender.values,
                validator: genderValidator,
                onSelected: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 45,
          ),
          ElevatedButton(
            key: Keys.registerButton,
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final User user = User(
                  name: _nameController.text,
                  age: int.parse(_ageController.text),
                  gender: _selectedGender ?? Gender.nonBinary,
                  userId: userId ?? "",
                );

                await ref.read(authControllerProvider.notifier).register(user);
              }
            },
            child: const Text(Strings.createAccount),
          ),
          const SizedBox(height: 15),
          TextButton(
            onPressed: ref.read(authControllerProvider.notifier).logOut,
            child: const Text(Strings.exit),
          ),
        ],
      ),
    );
  }
}
