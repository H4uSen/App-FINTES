import 'package:app_fintes/widgets/theme_config.dart';
import 'package:flutter/material.dart';


class DrawerNavTile extends StatelessWidget {
  const DrawerNavTile({
    super.key, required this.title, required this.icon, required this.iconBkgColor, 
    required this.onTap, this.subtitle, this.subColor, this.isDeposit,
    this.isSelected = false,
  });
  final String? subtitle;
  final bool isSelected;
  final String title;
  final IconData icon;
  final Color iconBkgColor;
  final Color? subColor;
  final bool? isDeposit;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50, top: 5, bottom: 5),
      child: ListTile(
        selected: isSelected,
        selectedTileColor: CustomColors.darkBlue,
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
        subtitle: 
          (subtitle != null )?
            Row(mainAxisAlignment: MainAxisAlignment.end ,
              children:[
                Text(subtitle!, 
                  style: TextStyle(
                    fontSize: 18, 
                    color: (subColor != null)? subColor: (subColor == null && isDeposit == null)? CustomColors.black: (isDeposit == true)? CustomColors.green: CustomColors.red,
                    ),),],)
            :null,
        title: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(title, style: Theme.of(context).textTheme.titleSmall, maxLines: 2, overflow: TextOverflow.ellipsis,),
          ),
        
        onTap: onTap,
      ),
    );
  }
}
