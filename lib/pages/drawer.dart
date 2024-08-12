import 'package:app_fintes/business_logic/data/globals.dart';
import 'package:app_fintes/business_logic/models/account_model.dart';
import 'package:app_fintes/business_logic/data_functions.dart';
import 'package:app_fintes/widgets/drawer/divider.dart';
import 'package:app_fintes/widgets/drawer/drawer_navtile.dart';
import 'package:app_fintes/widgets/drawer/setting_navtile.dart';
import 'package:app_fintes/widgets/theme_config.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    List<Account> accounts = getUserAccounts(globalUser!.id);
    bool hasAccounts = accounts.isEmpty;
    List<Account> goals = getUserGoals(globalUser!.id);
    bool hasGoals = goals.isEmpty;
    List<Account> recurrents = getUserRecurrents(globalUser!.id);
    bool hasRecurrents = recurrents.isEmpty;

    return Drawer(
      backgroundColor: CustomColors.lightBlue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DrawerHeader(
            decoration:const BoxDecoration(
              color: CustomColors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/fintes_app.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
                Padding(
                  padding:const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 150,
                    child: Text(
                      globalUser!.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: CustomColors.black,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: ListView(
              children: [

                DrawerNavTile(
                  title: 'Inicio', 
                  icon: Icons.home_rounded, 
                  iconBkgColor: CustomColors.white, 
                  onTap: (){
                    Navigator.pushNamed(context, '/home');
                  },
                ),
                

                //TODO: Hacer que los botones se les ponga una sombra para identificar la pagina actual y añadir la navegación a las otras paginas
                const CustomDivider(title: 'Cuentas'),
                for (var account in accounts)
                  if (account.accountType == AccountType.account)
                    DrawerNavTile(
                      title: account.accountName, 
                      icon: Icons.attach_money_rounded, 
                      onTap: (){
                        Navigator.pushNamed(context, '/accountdetails', arguments: account);
                      }, 
                      iconBkgColor: CustomColors.green,
                    ),

                Visibility(
                  visible: hasAccounts,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: CustomDivider(title: 'Vacío', showLines: false),
                  ),
                ),


                const CustomDivider(title: 'Metas'),
                for (var account in goals)
                  if (account.accountType == AccountType.goal)
                    DrawerNavTile(
                      title: account.accountName, 
                      icon: Icons.flag_rounded, 
                      onTap: (){
                        Navigator.pushNamed(context, '/accountdetails', arguments: account);
                      }, 
                      iconBkgColor: CustomColors.yellow,
                    ),
                Visibility(
                  visible: hasGoals,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: CustomDivider(title: 'Vacío', showLines: false),
                  ),
                ),


                const CustomDivider(title: 'Pagos recurrentes'),
                for (var account in recurrents)
                  if (account.accountType == AccountType.recurrentPayment)
                    DrawerNavTile(
                      title: account.accountName, 
                      icon: Icons.lock_clock,
                      subtitle: fixedCurrency(account.recurrentAmount!, "L."),
                      subColor: CustomColors.red,
                      onTap: (){
                        Navigator.pushNamed(context, '/accountdetails', arguments: account);
                      }, 
                      iconBkgColor: CustomColors.red,
                    ),
                Visibility(
                  visible: hasRecurrents,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: CustomDivider(title: 'Vacío', showLines: false),
                  ),
                ),
                
              ],
            ),
          ),
      
          SettingNavtile(title: 'Gestionar cuenta',icon: Icons.settings, 
          onTap: () => Navigator.pushReplacementNamed(context, '/accountmanagement'),
          ),

          SettingNavtile(
              title: 'Cerrar sesión', 
              icon: Icons.logout_outlined,
              onTap: () => Navigator.pushReplacementNamed(context, '/principal'),
              ),
          
        ],
      ),
      
    );
  }
}

