

import 'package:app_fintes/business_logic/transaction_details.dart';
import 'package:app_fintes/widgets/theme_config.dart';
import 'package:flutter/material.dart';


class RecentActivityTile extends StatelessWidget {
  final String title;
  final String description;
  final String account;
  final double amount;
  final bool isDeposit;
  final void Function()? onTap;


  const RecentActivityTile({super.key, 
    required this.title,
    required this.description,
    required this.account,
    required this.amount,
    required this.isDeposit, this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        
        borderRadius: BorderRadius.circular(12.0),
        side: const BorderSide(
          color: CustomColors.darkBlue,
          width: 1,
        ),
      ),
      color: CustomColors.lightBlue,
      child: ListTile(
        visualDensity: VisualDensity.compact,
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: isDeposit ? CustomColors.green : CustomColors.red,
          child: const Icon(
            Icons.attach_money_rounded,
            color: CustomColors.black,
            size: 45,
          ),
        ),
        title: Container(
          padding: const EdgeInsets.only(left: 10),
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(
                color: CustomColors.darkBlue,
                width: 1,
                
              ),
            ),
          ),
          child: Text(title, style: Theme.of(context).textTheme.titleSmall,)),
        subtitle: Container(
          padding: const EdgeInsets.only(left: 10),
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(
                color: CustomColors.darkBlue,
                width: 1,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(description, 
                style: Theme.of(context).textTheme.bodySmall!.apply(color: CustomColors.darkBlue,), 
                maxLines: 3,
                overflow: TextOverflow.ellipsis,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        Text('Cuenta: ', 
                        style: Theme.of(context).textTheme.bodySmall!.apply(color: CustomColors.darkBlue),),
                        SizedBox(width: 200, 
                        child: Text(account, style: Theme.of(context).textTheme.bodySmall!.apply(color: CustomColors.black),
                        maxLines: 1, 
                        overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(fixedCurrency(amount, 'L.'), 
                    style: Theme.of(context).textTheme.bodyMedium!.apply(color:isDeposit?CustomColors.green:CustomColors.red),
                  ),
                ],
              )
            ],
          ),
        ),
        contentPadding: const EdgeInsets.all(10),
        onTap: onTap,
      ),
    );
  }
}
