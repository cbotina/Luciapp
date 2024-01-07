import 'package:flutter/material.dart';
import 'package:luciapp/features/auth/domain/enums/gender.dart';

class EnumDropdownMenu<T> extends StatelessWidget {
  final String label;
  final Function(T?) onSelected;
  final List<T> values;

  const EnumDropdownMenu({
    super.key,
    required this.label,
    required this.onSelected,
    required this.values,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<T>(
      inputDecorationTheme: InputDecorationTheme(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        suffixIconColor: Theme.of(context).colorScheme.primary,
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
      width: MediaQuery.of(context).size.width * .85 - 60,
      menuStyle: MenuStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      label: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
      textStyle: Theme.of(context).textTheme.bodyMedium,
      onSelected: onSelected,
      dropdownMenuEntries: values.map<DropdownMenuEntry<T>>(
        (T value) {
          return DropdownMenuEntry<T>(
            value: value,
            label: value.toString(),
            style: ButtonStyle(
              textStyle: MaterialStatePropertyAll(
                  Theme.of(context).textTheme.bodyLarge),
            ),
            leadingIcon: value.toString().toIcon(),
          );
        },
      ).toList(),
    );
  }
}
