import 'package:flutter/material.dart';

ElevatedButton button({
  required BuildContext context,
  required VoidCallback onPressed,
  required String text,
  required Color backgroundColor,
  bool circularButton = true,
}) {
  return ElevatedButton(
    onPressed: () {
      onPressed.call();
    },

    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      shape: !circularButton
          ? RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(10.0),
            )
          : null,
    ),

    child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
  );
}
