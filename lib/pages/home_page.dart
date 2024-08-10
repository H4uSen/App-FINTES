import 'package:app_fintes/business_logic/transaction_details.dart';
import 'package:app_fintes/widgets/drawer/divider.dart';
import 'package:app_fintes/pages/drawer.dart';
import 'package:app_fintes/widgets/home/goal_card.dart';
import 'package:app_fintes/widgets/home/recentactivity_tile.dart';
import 'package:app_fintes/widgets/theme_config.dart';
import 'package:flutter/material.dart';
import '../business_logic/dummy_data.dart';


class InicioPage extends StatefulWidget {
  const InicioPage({super.key});
  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  
  var goalsRegistries = registries.where((e)=> e.account.accountType == AccountType.goal).toList();
  double goalCollected = 0;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text(
          'Inicio',
        ),
        centerTitle: true,
      ),
      
      body: Column(
        children: [
          const CustomDivider(title: 'Resumen de metas'),
          Expanded(
            child: ListView.builder(
                  
                  itemCount: goalsRegistries.length,
                  itemBuilder: (context, index) {
                      double goal = (goalsRegistries[index].account.goalAmount == null) ? 0: goalsRegistries[index].account.goalAmount!;
                      double collected = (goalsRegistries[index].account.goalAmount == null) ? 0: goalsRegistries[index].account.getGoalCollected(goalsRegistries, goalsRegistries[index].account.accountName);
                      return GoalCard(
                      title: goalsRegistries[index].account.accountName,
                      row1: 'Objetivo:',
                      row2: 'Reunido:',
                      row3: 'Restante:',
                      money1: goal,
                      money2: collected,
                      money3: goal - collected,
                      onTap: (){
                        Navigator.pushNamed(context, '/accountdetails', arguments: goalsRegistries[index].account);
                      },
                      showLeadingButton: true,
                    );
                    
                  },
                ),
          ),
          const CustomDivider(title: 'Actividades recientes'),
          Expanded(
            child: ListView.builder(
                  
                  itemCount: registries.length,
                  itemBuilder: (context, index) {
                      return RecentActivityTile(
                      title: registries[index].title,
                      description: registries[index].description,
                      account: registries[index].account.accountName,  
                      amount: registries[index].amount,
                      isDeposit: registries[index].isDeposit,
                      onTap: (){
                        Navigator.pushNamed(context, '/registrydetails', arguments: registries[index]);
                      },
                    );
                    
                  },
                ),
          ),
          

        ],
      ),

          
      
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: CustomColors.black,
        child: const Icon(Icons.add, color: CustomColors.white,)
      ),
    );
  }
}

