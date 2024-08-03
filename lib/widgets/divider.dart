import 'package:app_fintes/widgets/theme_config.dart';
import 'package:flutter/material.dart';


class CustomDivider extends StatefulWidget {
  final String title;
  const CustomDivider({
    super.key, required this.title
  });



  @override
  State<CustomDivider> createState() => _CustomDividerState();
}

class _CustomDividerState extends State<CustomDivider> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    
      children: [
        const SizedBox(
          width: 100,
          child: Divider(
            color: CustomColors.darkBlue,
            thickness: 1,
          ),
        ),
        Text(widget.title, style: const TextStyle(color: CustomColors.darkBlue),),
        const SizedBox(
          width: 100,
          child: Divider(
            color: CustomColors.darkBlue,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}

