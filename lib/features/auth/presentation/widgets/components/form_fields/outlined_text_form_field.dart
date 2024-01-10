import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OutlinedTextFormField extends StatelessWidget {
  final String? initialValue;
  final String label;
  final bool isNumberField;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const OutlinedTextFormField({
    super.key,
    this.initialValue,
    required this.label,
    this.controller,
    this.isNumberField = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      initialValue: initialValue,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        label: Text(label),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      inputFormatters: isNumberField
          ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))]
          : null,
      keyboardType: isNumberField ? TextInputType.number : TextInputType.text,
      onTapOutside: (e) {
        FocusScope.of(context).unfocus();
      },
      validator: validator,
    );
  }
}
