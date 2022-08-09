import 'package:flutter/material.dart';

import '../../constants/kConstants.dart';

typedef CloseDialog = void Function();

CloseDialog showLoadingDialog({
  required BuildContext context,
  required String text,
}) {
  final dialog = AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        k10SizedBox,
        const CircularProgressIndicator(),
        k10SizedBox,
        Text(text),
      ],
    ),
  );
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (context) => dialog,
  );

  //fix this

  return () => Navigator.of(context).pop();
}
