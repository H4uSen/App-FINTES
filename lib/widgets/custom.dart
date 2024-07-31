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
    this.obscureText = false, // Añadido
  });

  final String label;
  final String hintText;
  final TextEditingController controller;
  final Icon? icon;
  final IconButton? icon1;
  final String? Function(String?)? validator;
  final bool obscureText; // Añadido

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText, // Utilizar el parámetro aquí
      keyboardType: TextInputType.text,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: label,
        prefixIcon: icon,
        suffixIcon: icon1,
        border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        errorText: null,
      ),
    );
  }
}