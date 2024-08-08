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
      body: ListView(
        children: [
          const CustomDivider(title: 'Resumen de metas'),
          //#TODO: Implementar la navegación a la pantalla de registros
          GoalCard(title: 'Carros', goal: 20000, collected: 10000, onTap: (){},),
          const CustomDivider(title: 'Actividades recientes'),
          const RecentActivityTile(
            title: 'Dinero recibido por x cosa',
            description: 'este es un ejemplo de una actividad reciente con una descripción larga, me gustaria ver como se ve y que se ajuste de manera correcta en la pantalla',
            account: 'Cuenta de ahorros',  
            amount: 100000,
            isDeposit: false,
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

