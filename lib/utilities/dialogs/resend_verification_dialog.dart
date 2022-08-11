import 'package:flutter/material.dart';
import 'package:takenote/utilities/dialogs/generic_dialog.dart';

Future<void> showResendVerificationDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Resent verification',
    content:
        'Verification email has been resent. Please check your inbox/spam folder.',
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
