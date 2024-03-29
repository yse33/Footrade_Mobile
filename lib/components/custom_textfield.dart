import 'package:flutter/material.dart';

import '../constants/app_icons.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData prefixIcon;
  final bool obscureText;
  final String? Function(String?) validator;
  final void Function()? onPressed;

  const CustomTextField({
    key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    required this.obscureText,
    required this.validator,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(prefixIcon),
          suffixIcon: onPressed != null ? IconButton(
            icon: Icon(
              obscureText ? AppIcons.visibility : AppIcons.visibilityOff,
            ),
            onPressed: onPressed,
          ) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: validator,
        obscureText: obscureText,
      ),
    );
  }
}