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
      /*body: ListView(
        children: [
          const CustomDivider(title: 'Resumen de metas'),
          //#TODO: Implementar la navegación a la pantalla de registros
          GoalCard(title: 'Carros', goal: 20000, collected: 10000, onTap: (){},showLeadingButton: false,),

          const CustomDivider(title: 'Actividades recientes'),
          RecentActivityTile(
            title: 'Dinero recibido por x cosa',
            description: 'este es un ejemplo de una actividad reciente con una descripción larga, me gustaria ver como se ve y que se ajuste de manera correcta en la pantalla',
            account: 'Cuenta de ahorros',  
            amount: 100000,
            isDeposit: true,
            onTap:(){},
          ),
          RecentActivityTile(
            title: 'Compra X Amazon',
            description: 'este es un ejemplo de una actividad reciente con una descripción larga, me gustaria ver como se ve y que se ajuste de manera correcta en la pantalla',
            account: 'Tarjeta 1',  
            amount: 500,
            isDeposit: false,
            onTap:(){},
          ),
        ],  

      ),*/
      
      body: Column(
        children: [
          const CustomDivider(title: 'Resumen de metas'),
          Expanded(
            child: ListView.builder(
                  itemCount: goalsRegistries.length,
                  itemBuilder: (context, index) {
                      return GoalCard(
                      title: goalsRegistries[index].account.accountName,
                      goal: (goalsRegistries[index].account.goalAmount == null) ? 0: goalsRegistries[index].account.goalAmount!,
                      collected: (goalsRegistries[index].account.goalAmount == null) ? 0: goalsRegistries[index].account.goalCollected(goalsRegistries),
                      onTap: (){
                        Navigator.pushNamed(context, '/registrydetails', arguments: registries[index]);
                      },
                      showLeadingButton: true,
                    );
                    
                  },
                ),
          ),

          const CustomDivider(title: 'Actividades recientes'),
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

