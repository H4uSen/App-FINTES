import 'package:app_fintes/business_logic/models/account_model.dart';
import 'package:app_fintes/widgets/theme_config.dart';
import 'package:flutter/material.dart';


class CustomDropDown extends StatelessWidget {

  const CustomDropDown({
    super.key,
    required this.isEditable, required this.labeltext, required this.options,
  });

  final bool isEditable;
  final String labeltext;
  final List<DropdownMenuItem<String>> options;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        enabled: isEditable,
        labelText: labeltext,
        labelStyle: Theme.of(context).textTheme.bodyLarge!.apply(fontWeightDelta: 2),
        
      ),
      itemHeight: 50,
      style: Theme.of(context).textTheme.bodyMedium!.apply(color: CustomColors.black),
      isExpanded: true,
      value: options[0].value,
      items: options,
      onChanged: (String? value) {
        
      },
    );
  }
}
