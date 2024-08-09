// widgets/acct_listtile.dart
import 'package:flutter/material.dart';
import 'package:app_fintes/widgets/theme_config.dart';

class AcctListtile extends StatelessWidget {
  final String title;
  final IconData leadingIcon;
  final IconData editIcon;
  final IconData deleteIcon;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Color leadingIconBackgroundColor;
  final Color leadingIconColor;

  const AcctListtile({
    super.key,
    required this.title,
    required this.leadingIcon,
    required this.editIcon,
    required this.deleteIcon,
    required this.onEdit,
    required this.onDelete,
    this.leadingIconBackgroundColor = Colors.green,
    this.leadingIconColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        border: Border.all(color: CustomColors.darkBlue, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        leading: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: leadingIconBackgroundColor,
            shape: BoxShape.circle,
          ),
          child: Icon(leadingIcon, color: leadingIconColor),
        ),
        title: Text(title, style: const TextStyle(fontSize: 18, color: Colors.black)),
        trailing: SizedBox(
          width: 120, 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(editIcon, color: CustomColors.darkBlue),
                onPressed: onEdit,
              ),
              Container(
                width: 2,
                height: 28, 
                color: CustomColors.darkBlue,
                margin: const EdgeInsets.symmetric(horizontal: 8.0), 
              ),
              IconButton(
                icon: Icon(deleteIcon, color: CustomColors.darkBlue),
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}