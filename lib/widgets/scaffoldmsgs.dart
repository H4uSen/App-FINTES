import 'package:app_fintes/widgets/theme_config.dart';
import 'package:flutter/material.dart';

void successScaffoldMsg(BuildContext context,String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: CustomColors.lightBlue,
        content: Text(message, 
          style: Theme.of(context).textTheme.titleSmall!.apply(color: CustomColors.black)),
        duration: const Duration(seconds: 3),
        
      ),
    );
  }

  void scaffoldErrorMsg(BuildContext context, String message) {
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
              maxLines: 1, 
              style: Theme.of(context).textTheme.bodyMedium!.apply(color: CustomColors.black,)),
          ],
        ),
        backgroundColor: CustomColors.lightBlue,
      ),
    );
  }