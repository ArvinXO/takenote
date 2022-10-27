import 'package:flutter/material.dart';
import 'package:takenote/utilities/dialogs/generic_dialog.dart';

Future<bool> showDeleteAllDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Delete',
    content:
        'Are you sure you want to delete all the items in the Deleted Notes folder?',
    optionsBuilder: () => {
      'Cancel': false,
      'Yes': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
