import 'package:flutter/material.dart';
import 'package:luciapp/features/auth/domain/enums/gender.dart';

class EnumDropdownButtonFormField<T> extends StatelessWidget {
  final String label;
  final List<T> values;
  final Function(T?) onSelected;
  final String? Function(T?)? validator;

  const EnumDropdownButtonFormField({
    super.key,
    required this.label,
    required this.onSelected,
    required this.values,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      items: values.map<DropdownMenuItem<T>>(
        (T value) {
          return DropdownMenuItem<T>(
            value: value,
            child: Row(
              children: [
                value.toString().toIcon() ??
                    const Icon(Icons.arrow_forward_ios),
                Text(
                  "  ${value.toString()}",
                ),
              ],
            ),
          );
        },
      ).toList(),
      onChanged: onSelected,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        suffixIconColor: Theme.of(context).colorScheme.primary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      style: Theme.of(context).textTheme.bodyMedium,
      iconEnabledColor: Theme.of(context).colorScheme.primary,
      hint: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Theme.of(context).colorScheme.primary),
      ),
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
