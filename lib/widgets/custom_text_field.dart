import 'package:flutter/material.dart';
import 'package:pocket_tasks/providers/search_provider.dart';
import 'package:pocket_tasks/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.icon,
    required this.hint,
    this.controller,
    this.searchNotifier,
  });
  final String hint;
  final Icon? icon;
  final TextEditingController? controller;
  final SearchNotifier? searchNotifier;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: Theme.of(context).textTheme.bodyMedium,
      textCapitalization: TextCapitalization.sentences,
      cursorColor: white,
      decoration: InputDecoration(
        filled: true,
        fillColor: textFieldColor,
        hintText: hint,

        hintStyle: TextStyle(color: hintTextColor),
        enabledBorder: border(color: enabledBorderColor),
        focusedBorder: border(color: focusedBorderColor),
        prefixIcon: icon,
      ),
      onChanged: (value) {
        searchNotifier?.updateText(value);
      },
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
    );
  }
}

OutlineInputBorder border({required Color color}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: color),
  );
}
