import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalTextField extends StatelessWidget {
  final validator;
  final controller;
  final prefixIcon;
  final obscureText;
  final suffixIcon;
  final hint;

  const GlobalTextField({
    this.validator,
    this.controller,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: obscureText ?? false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.emailAddress,
      controller: controller,
      style: Get.textTheme!.bodyText1!.copyWith(color: Colors.black),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hint,
        labelText: hint,
      ),
    );
  }
}
