import 'package:app_fintes/business_logic/account_functions.dart';
import 'package:app_fintes/business_logic/data/globals.dart';
import 'package:app_fintes/business_logic/goal_functions.dart';
import 'package:app_fintes/business_logic/models/account_model.dart';
import 'package:app_fintes/business_logic/models/goal_model.dart';
import 'package:app_fintes/business_logic/models/recurrent_model.dart';
import 'package:app_fintes/business_logic/recurrent_functions.dart';
import 'package:app_fintes/business_logic/utilitity_functions.dart';
import 'package:app_fintes/pages/principal_page.dart';
import 'package:app_fintes/widgets/drawer/divider.dart';
import 'package:app_fintes/widgets/drawer/drawer_navtile.dart';
import 'package:app_fintes/widgets/drawer/setting_navtile.dart';
import 'package:app_fintes/widgets/theme_config.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({super.key});

  final List<Account> accounts = getUserAccounts(globalUser!.id);
  final List<Goal> goals = getUserGoals(globalUser!.id);
  final List<RecurrentPayment> recurrents = getUserRecurrents(globalUser!.id);
  

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    // final List<Account> accounts = getUserAccounts(globalUser!.id);
    bool hasAccounts = widget.accounts.isEmpty;
    // List<Account> goals = getUserGoals(globalUser!.id);
    bool hasGoals = widget.goals.isEmpty;
    // List<Account> recurrents = getUserRecurrents(globalUser!.id);
    bool hasRecurrents = widget.recurrents.isEmpty;

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
                  isSelected: 'Inicio' == getSelectedDrawerOption(),
                  title: 'Inicio', 
                  icon: Icons.home_rounded, 
                  iconBkgColor: CustomColors.white, 
                  onTap: (){
                    Navigator.pushNamed(context, '/home');
                    setSelectedDrawerOption('Inicio');
                    setState(() {});
                  },
                  
                ),
                

                const CustomDivider(title: 'Cuentas'),
                for (var account in widget.accounts)
                    DrawerNavTile(
                      isSelected: account.accountName == getSelectedDrawerOption(),
                      title: account.accountName, 
                      icon: Icons.attach_money_rounded, 
                      onTap: (){
                        Navigator.pushNamed(context, 
                          '/accountdetails', 
                          arguments: [account.accountType,account.accountId,account.accountName]);
                        setSelectedDrawerOption(account.accountName);
                        setState(() {});
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
                for (var goal in widget.goals)
                    DrawerNavTile(
                      isSelected: goal.goalName == getSelectedDrawerOption(),
                      title: goal.goalName, 
                      icon: Icons.flag_rounded, 
                      onTap: (){
                        Navigator.pushNamed(context, 
                          '/accountdetails', 
                          arguments: [goal.accountType,goal.goalId,goal.goalName]);
                        setSelectedDrawerOption(goal.goalName);
                        setState(() {});
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
                for (var recurrent in widget.recurrents)
                    DrawerNavTile(
                      isSelected: recurrent.recurrentName == getSelectedDrawerOption(),
                      title: recurrent.recurrentName, 
                      icon: Icons.lock_clock,
                      subtitle: fixedCurrency(recurrent.recurrentAmount, "L."),
                      subColor: (recurrent.isDeposit) ? CustomColors.green : CustomColors.red,
                      onTap: (){
                        Navigator.pushNamed(context, 
                          '/accountdetails', 
                          arguments:[ recurrent.accountType,recurrent.recurrentId,recurrent.recurrentName]);
                        setSelectedDrawerOption(recurrent.recurrentName);
                        setState(() {});
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
          onTap: () => Navigator.pushNamed(context, '/accountmanagement'),
          ),

          SettingNavtile(
              title: 'Cerrar sesión', 
              icon: Icons.logout_outlined,
              onTap: () => {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PrincipalPage())),
                  globalUser = null,
                  
                },
              ),
          
        ],
      ),
      
    );
  }
}

void drawerSelectedControl(String accountSelected){
  List<Account> accounts = getUserAccounts(globalUser!.id);
  if(accounts.isEmpty) return;
}

