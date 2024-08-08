import 'package:app_fintes/business_logic/transaction_details.dart';
import 'package:app_fintes/widgets/theme_config.dart';
import 'package:flutter/material.dart';

class GoalCard extends StatefulWidget {
  const GoalCard({super.key, required this.title, required this.goal, required this.collected, this.showLeadingButton = true, this.onTap, });

  final String title;
  final double goal;
  final double collected;
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
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
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
                      GoalCardRow(title: 'Meta:', amount: widget.goal, ),
                      GoalCardRow(title: 'Reunido:', amount: widget.collected),
                      GoalCardRow(title: 'Restante:', amount: widget.goal - widget.collected, bkgColor: CustomColors.lightBlue,),
                      
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
    this.bkgColor = Colors.transparent,
  });

  final String title;
  final double amount;
  final Color bkgColor;
  
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
            Text(fixedCurrency(amount, 'L.'), style: descriptionStyle,),
          ],
        ),
      ),
    );
  }
}
