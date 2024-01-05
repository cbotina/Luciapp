import 'package:flutter/material.dart';
import 'package:luciapp/common/dialogs/dialog_template.dart';
import 'package:luciapp/features/auth/presentation/widgets/create_account_dialog_body.dart';

@immutable
class CreateAccountDialog extends DialogTemplate<bool> {
  const CreateAccountDialog()
      : super(
          body: const CreateAccountDialogBody(),
          buttons: const {
            'OK': true,
          },
        );
}
