import 'package:flutter/material.dart';
import 'package:luciapp/common/extensions/int_to_duration.dart';

@immutable
class DialogTemplate<T> {
  final Widget body;
  final Map<String, T> buttons;

  const DialogTemplate({
    required this.body,
    required this.buttons,
  });
}

extension Present<T> on DialogTemplate<T> {
  Future<T?> present(BuildContext context) {
    return showGeneralDialog(
      context: context,
      transitionDuration: 200.ms,
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      transitionBuilder: (context, a1, a2, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: .5, end: 1).animate(a1),
          child: AlertDialog(
            contentTextStyle: Theme.of(context).textTheme.bodyLarge,
            content: body,
            actionsAlignment: MainAxisAlignment.center,
            elevation: 5,
            actions: buttons.entries.map((entry) {
              return ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(entry.value);
                },
                child: Text(entry.key),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
