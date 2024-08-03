import 'package:app_fintes/widgets/theme_config.dart';
import 'package:flutter/material.dart';


class CustomDivider extends StatefulWidget {
  final String title;
  final bool showLines;
  const CustomDivider({
    super.key, required this.title, this.showLines = true
  });



  @override
  State<CustomDivider> createState() => _CustomDividerState();
}

class _CustomDividerState extends State<CustomDivider> {
  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: const EdgeInsets.only(top:10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Divider(
              color: (widget.showLines)?CustomColors.darkBlue: Colors.transparent,
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(widget.title, style: const TextStyle(color: CustomColors.darkBlue,fontSize: 15),),
          ),
          Expanded(
            child: Divider(
              color: (widget.showLines)?CustomColors.darkBlue: Colors.transparent,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}

