import 'package:flutter/material.dart';
import 'package:pocket_tasks/utils/colors.dart';

enum SnackBarType { normal, success, error }

void showAppSnackbar({
  required BuildContext context,
  required String message,
  VoidCallback? undo,
  SnackBarType snackBarType = SnackBarType.normal,
}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    snackBarType == SnackBarType.normal
        ? SnackBar(
            showCloseIcon: true,
            behavior: SnackBarBehavior.floating,
            action: undo != null
                ? SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      undo.call();
                    },
                  )
                : null,
            backgroundColor: neutral,
            content: Text(message, style: TextStyle(color: onNeutral)),
          )
        : snackBarType == SnackBarType.success
        ? SnackBar(
            showCloseIcon: true,
            behavior: SnackBarBehavior.floating,
            action: undo != null
                ? SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      undo.call();
                    },
                  )
                : null,
            backgroundColor: success,
            content: Text(message, style: TextStyle(color: onSuccess)),
          )
        : SnackBar(
            showCloseIcon: true,
            behavior: SnackBarBehavior.floating,
            action: undo != null
                ? SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      undo.call();
                    },
                  )
                : null,
            backgroundColor: error,
            content: Text(message, style: TextStyle(color: onError)),
          ),
  );
}
