import 'package:app_fintes/business_logic/models/account_model.dart';
import 'package:app_fintes/widgets/theme_config.dart';
import 'package:flutter/material.dart';


class CustomDropDown extends StatelessWidget {

  const CustomDropDown({
    super.key,
    required this.isEditable, required this.labeltext, required this.options,
    this.onChanged, required this.value,
  });

  final bool isEditable;
  final String labeltext;
  final String? value;
  final void Function(String?)? onChanged;
  final List<DropdownMenuItem<String>> options;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: DropdownButtonFormField<String>(
        
        iconSize: 40,
        decoration: InputDecoration(
          labelText: labeltext,
          labelStyle: Theme.of(context).textTheme.bodyLarge!.apply(fontWeightDelta: 2),
          
        ),
        itemHeight: 70,
        style: Theme.of(context).textTheme.bodyLarge!.apply(color: CustomColors.black),
        isExpanded: true,
        value: value,
        items: options,
        onChanged: (isEditable)?onChanged:null,
      ),
    );
  }
}
