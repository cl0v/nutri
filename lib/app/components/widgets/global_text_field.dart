import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalTextField extends StatelessWidget {
  final validator;
  final controller;
  final prefixIcon;
  final obscureText;
  final suffixIcon;
  final hint;
  final suffix;
  final keyboardType;

  const GlobalTextField({
    this.validator,
    this.controller,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.obscureText,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: obscureText ?? false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyboardType,
      controller: controller,
      style: Get.textTheme!.bodyText1!.copyWith(color: Colors.black),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffix: suffix,
        suffixIcon: suffixIcon,
        hintText: hint,
        labelText: hint,
      ),
    );
  }
}
