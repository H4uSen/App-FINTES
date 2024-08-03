import 'package:app_fintes/widgets/theme_config.dart';
import 'package:flutter/material.dart';


class DrawerNavTile extends StatelessWidget {
  const DrawerNavTile({
    super.key, required this.title, required this.icon, required this.iconBkgColor, required this.onTap, this.subtitle
  });
  final String? subtitle;
  final String title;
  final IconData icon;
  final Color iconBkgColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: ListTile(
        visualDensity: VisualDensity.compact,
        tileColor: CustomColors.white,
        shape: const RoundedRectangleBorder(
          side: BorderSide(width: 1, color: CustomColors.darkBlue),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        leading: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: iconBkgColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(icon, color: CustomColors.black, size: 40),
        ),
        subtitle: (subtitle != null)?Text('Hello', style: Theme.of(context).textTheme.bodySmall,):null,
        title: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(title, style: Theme.of(context).textTheme.bodyLarge, maxLines: 1, overflow: TextOverflow.ellipsis,),
          ),
        onTap: onTap,
      ),
    );

    
  }
}
