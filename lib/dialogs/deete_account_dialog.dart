import 'package:bloc_state_mngmnt/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart' show BuildContext;

Future<bool> showDeleteAccountDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Delete Account',
    content:
        'Are you sure want to delete your account? You can not undo this operation!',
    optionsBuilder: () => {
      'Cancel': false,
      'Delete account': true,
    },
  ).then((value) => value ?? false);
}



