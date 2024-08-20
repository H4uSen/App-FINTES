import 'package:app_fintes/widgets/theme_config.dart';
import 'package:flutter/material.dart';

void successScaffoldMsg(BuildContext context,String message, 
  {Color backgroundColor = CustomColors.lightBlue, Color textColor = CustomColors.black}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        content: Text(
          message, 
          style: Theme.of(context).textTheme.titleSmall!.apply(color: textColor),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          ),
        duration: const Duration(seconds: 3),
        
      ),
    );
  }

  void errorScaffoldMsg(BuildContext context, String message,
  {Color backgroundColor = CustomColors.lightBlue, Color textColor = CustomColors.black}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(4),
              child: Icon(Icons.error,size: 40,color: CustomColors.darkBlue,),
            ),
            Text(message,
              overflow: TextOverflow.ellipsis,
              maxLines: 2, 
              style: Theme.of(context).textTheme.bodyMedium!.apply(color: textColor,)),
          ],
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }