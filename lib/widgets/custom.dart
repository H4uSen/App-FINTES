// widgets/custom.dart
import 'package:app_fintes/widgets/theme_config.dart';
import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  const CustomForm({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.icon1,
    this.validator,
    this.obscureText = false, 
    this.maxLength, // Añadido
  });

  final String label;
  final int? maxLength;
  final String hintText;
  final TextEditingController controller;
  final Icon? icon;
  final IconButton? icon1;
  final String? Function(String?)? validator;
  final bool obscureText; 

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      keyboardType: TextInputType.text,
      style: const TextStyle(fontSize: 18),
      maxLength: maxLength,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: label,
        prefixIcon: icon,
        suffixIcon: icon1,
        border: const OutlineInputBorder(borderSide: BorderSide(color: CustomColors.black)),
        labelStyle: const TextStyle(fontSize: 18),
        hintStyle: const TextStyle(fontSize: 18),
        errorText: null,
      ),
    );
  }
}