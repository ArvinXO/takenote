import 'package:flutter/material.dart';
import 'package:takenote/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: 'Password Reset',
    content:
        'We have sent you an email with a link to reset your password, please check your email for further instructions.',
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
