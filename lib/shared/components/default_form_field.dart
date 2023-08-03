import 'package:flutter/material.dart';

class DefaultTextFormFields extends StatelessWidget {
  const DefaultTextFormFields({
    Key? key,
    this.onTap,
    required this.textEditingController,
    required this.type,
    required this.prefix,
    required this.label,
    this.isClickable = true,
    this.isPassword = false,
    this.suffixIcon,
    this.onSubmitted,
    this.suffixPressed,
  });

  final TextEditingController textEditingController;
  final TextInputType type;
  final Icon prefix;
  final String label;
  final void Function()? onTap;
  final bool? isClickable;
  final bool isPassword;
  final IconData? suffixIcon;
  final void Function(String?)? onSubmitted;
  final void Function()? suffixPressed;

  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      onFieldSubmitted: onSubmitted,
      onTap: onTap,
      controller: textEditingController,
      keyboardType: type,
      validator: (value) {
        if (value!.isEmpty) {
          return 'field is required';
        } else {
          return null;
        }
      },
      enabled: isClickable!,
      decoration: InputDecoration(
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: suffixPressed,
                  icon: Icon(
                    suffixIcon,
                  ),
                )
              : null,
          enabledBorder: buildBorder(),
          focusedBorder: buildBorder(),
          prefixIcon: prefix,
          label: Text(label),
          border: buildBorder()),
    );
  }
}

OutlineInputBorder buildBorder({Color? color}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(6),
    borderSide: BorderSide(color: color ?? Colors.black),
  );
}
