import 'package:app_fintes/widgets/theme_config.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key, 
    required this.labelText, 
    required this.isEditable,
    required this.initialValue,
    this.prefixText,
    this.prefixIcon,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textAlignment = TextAlign.start,
    this.maxLength = 50,
    this.minLines = 1,
    this.maxLines = 1, 
  });
  final TextInputType keyboardType;
  final TextAlign textAlignment;
  final Widget? prefixIcon;
  final String? prefixText;

  
  final String? Function(String?)? validator;
  final String initialValue;
  final String labelText;
  final bool isEditable;
  final int maxLength;
  final int minLines;
  final int maxLines;


  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: (widget.initialValue.isEmpty)?'Sin ${widget.labelText.toLowerCase()}':widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }



  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric( vertical: 10),
      child: TextFormField(
        controller: _controller,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        textAlign: widget.textAlignment,
        keyboardType: widget.keyboardType,
        style: Theme.of(context).textTheme.bodyMedium!.apply( color: CustomColors.black),
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          prefixText: widget.prefixText,
          prefixStyle: Theme.of(context).textTheme.bodyLarge!.apply(fontWeightDelta: 2, color: CustomColors.lightBlue),
          labelText: widget.labelText, 
          labelStyle: Theme.of(context).textTheme.bodyLarge!.apply(fontWeightDelta: 2),
          border: const OutlineInputBorder(),
          fillColor: Colors.white,
          enabled: widget.isEditable,
        ),
        validator: widget.validator,
        onChanged: (value){
          //_controller

        },
      ),
    );
  }
}