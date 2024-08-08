import 'package:app_fintes/widgets/theme_config.dart';
import 'package:flutter/material.dart';

class SettingNavtile extends StatelessWidget {
  const SettingNavtile({
    super.key, required this.title, required this.icon, this.subtitle, this.onTap 
  });
  final String title;
  final String? subtitle;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitle: (subtitle != null)?Text('Hello', style: Theme.of(context).textTheme.bodySmall,):null,
      visualDensity: VisualDensity.comfortable,
      tileColor: CustomColors.white,
      shape: const RoundedRectangleBorder(
        side: BorderSide(width: 1, color: CustomColors.darkBlue),
      ),
      leading: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: CustomColors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Icon(icon, color: CustomColors.black, size: 40),
      ),
      title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(title, style: Theme.of(context).textTheme.bodyMedium,maxLines: 1, overflow: TextOverflow.ellipsis,),
        ),
      onTap: onTap
      );
  }
}