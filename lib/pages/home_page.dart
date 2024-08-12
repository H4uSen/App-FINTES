import 'package:app_fintes/business_logic/data_functions.dart';
import 'package:app_fintes/business_logic/models/account_model.dart';
import 'package:app_fintes/business_logic/models/registry_model.dart';
import 'package:app_fintes/business_logic/models/user_model.dart';
import 'package:app_fintes/widgets/drawer/divider.dart';
import 'package:app_fintes/pages/drawer.dart';
import 'package:app_fintes/widgets/home/goal_card.dart';
import 'package:app_fintes/widgets/home/recentactivity_tile.dart';
import 'package:app_fintes/widgets/theme_config.dart';
import 'package:flutter/material.dart';


class InicioPage extends StatefulWidget {
  const InicioPage({super.key});
  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  
  
//TODO: Hay que hacer que la pantalla home se actualice cada vez que se agrega un nuevo registro por medio del boton flotante
  @override
  Widget build(BuildContext context) {
  User user = ModalRoute.of(context)!.settings.arguments as User;
  List<Registry> allRegistries = getAllUserRegistries(user.id);
  List<Account> goalAccounts = getUserGoals(user.id);

    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title:  Text(
          'Inicio',
        ),
        centerTitle: true,
      ),
      //TODO: Hacer que se vea un mensaje de vacio si no hay metas o registros
      body: Column(
        children: [
          const CustomDivider(title: 'Resumen de metas'),
          SizedBox(
            height: 250,
            child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: goalAccounts.length,
                  itemBuilder: (context, index) {
                      double goal = goalAccounts[index].goalAmount ?? 0;
                      double collected = getAccountCollected(user.id, goalAccounts[index].accountId);
                      return SizedBox(
                        width: 300,
                        child: GoalCard(
                          title: goalAccounts[index].accountName,
                          row1: 'Objetivo:',
                          row2: 'Reunido:',
                          row3: 'Restante:',
                          money1: goal,
                          money2: collected,
                          money3: goal - collected,
                          onTap: (){
                            Navigator.pushNamed(context, '/accountdetails', arguments: goalAccounts[index]);
                          },
                          showLeadingButton: true,
                        ),
                      );
                    
                  },
                ),
          ),

          

          const CustomDivider(title: 'Actividades recientes'),
          Expanded(
            child: ListView.builder(
                  
                  itemCount: allRegistries.length,
                  itemBuilder: (context, index) {
                      String? accountName = getAccountNameById(allRegistries[index].accountId);
                      return RecentActivityTile(
                      title: allRegistries[index].title,
                      description: allRegistries[index].description,
                      account: accountName ?? 'No se encontro la cuenta',  
                      amount: allRegistries[index].amount,
                      isDeposit: allRegistries[index].isDeposit,
                      onTap: (){
                        Navigator.pushNamed(context, '/registrydetails', arguments: allRegistries[index]);
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

