import 'package:flutter/material.dart';
import 'package:googleapis_auth/auth_io.dart';

Future<bool> showPrompt(BuildContext context) async {
  var result = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Grant Access'),
        content: Text('Our app needs access to your Google account. Please grant access to continue.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Grant Access'),
          ),
        ],
      );
    },
  );
  if (result == true) {
    return true;
  } else {
    return false;
  }
}
