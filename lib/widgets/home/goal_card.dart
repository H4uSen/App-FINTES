
import 'package:app_fintes/business_logic/utilitity_functions.dart';
import 'package:app_fintes/widgets/theme_config.dart';
import 'package:flutter/material.dart';

class GoalCard extends StatefulWidget {
  const GoalCard({super.key, required this.title, 
    this.showLeadingButton = true, this.onTap, required this.row1, required this.row2, 
    required this.row3, required this.money1, required this.money2, required this.money3, 
    this.currency1 = true, this.currency2 = true, this.currency3 = true, });

  final String title;
  final String row1, row2, row3;
  final double money1, money2, money3;
  final bool currency1, currency2, currency3;
  final bool showLeadingButton;
  final void Function()? onTap;

  @override
  State<GoalCard> createState() => _GoalCardState();
}
class _GoalCardState extends State<GoalCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: CustomColors.darkBlue,
                width: 2,
              ),
            ),
            child: Column(
              children: [
                Container(
                  decoration:BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    widget.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Divider(thickness: 2, color: CustomColors.darkBlue,),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10.0),
                      GoalCardRow(title: widget.row1, amount: widget.money1,showCurrency: widget.currency1,),
                      GoalCardRow(title: widget.row2, amount: widget.money2,showCurrency: widget.currency2,),
                      GoalCardRow(title: widget.row3, amount: widget.money3,showCurrency: widget.currency3, bkgColor: CustomColors.lightBlue,),
                      
                      if(widget.showLeadingButton)
                      ListTile(
                      visualDensity: VisualDensity.compact,
                        title: const Center(child: Text('Ver registros >',style: TextStyle(color: CustomColors.darkBlue, fontSize: 20),)),
                        onTap: widget.onTap,
                      )
                      else const SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}

class GoalCardRow extends StatelessWidget {
  const GoalCardRow({
    super.key,
    required this.title,
    required this.amount,
    this.showCurrency = true,
    this.bkgColor = Colors.transparent,
  });

  final String title;
  final double amount;
  final Color bkgColor;
  final bool showCurrency;
  
  @override
  Widget build(BuildContext context) {
      TextStyle descriptionStyle = const TextStyle(
        color: CustomColors.black,
        fontSize: 20,
      );
    return Container(
      color: bkgColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: descriptionStyle,),
            Text((showCurrency)?fixedCurrency(amount, (showCurrency)?'L.':""): int.parse(amount.round().toString()).toString(), style: descriptionStyle,),
          ],
        ),
      ),
    );
  }
}
