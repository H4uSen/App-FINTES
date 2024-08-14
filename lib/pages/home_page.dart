import 'package:app_fintes/business_logic/account_functions.dart';
import 'package:app_fintes/business_logic/data/globals.dart';
import 'package:app_fintes/business_logic/data_functions.dart';
import 'package:app_fintes/business_logic/goal_functions.dart';
import 'package:app_fintes/business_logic/models/account_model.dart';
import 'package:app_fintes/business_logic/models/goal_model.dart';
import 'package:app_fintes/business_logic/models/registry_model.dart';
import 'package:app_fintes/business_logic/models/user_model.dart';
import 'package:app_fintes/business_logic/recurrent_functions.dart';
import 'package:app_fintes/business_logic/registry_functions.dart';
import 'package:app_fintes/widgets/drawer/divider.dart';
import 'package:app_fintes/pages/drawer.dart';
import 'package:app_fintes/widgets/home/goal_card.dart';
import 'package:app_fintes/widgets/home/recentactivity_tile.dart';
import 'package:app_fintes/widgets/theme_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  if(globalUser == null) {
    Navigator.pushReplacementNamed(context, '/principal');
  }
  User user = globalUser!;
  // List<Registry> allRegistries = getAllUserRegistries(user.id);
  // List<Goal> goalAccounts = getUserGoals(user.id);

  final goalsRef = FirebaseFirestore.instance
        .collection('Goals')
        .withConverter(
          fromFirestore: (snapshot, _) => Goal.fromJson(snapshot.data()!,globalUser!.id),
          toFirestore: (model, _) => model.toJson(),
        );

    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title:  const Text(
          'Inicio',
        ),
        centerTitle: true,
      ),
      //TODO: Hacer que se vea un mensaje de vacio si no hay metas o registros
      body: Column(
        children: [

          FutureBuilder(
            future: goalsRef.get(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator());
              }
              if(snapshot.hasError){
                return const Center(child: Text('Error al cargar las metas'));
              }
              final querySnapshot = snapshot.data;

              if (querySnapshot == null) {
                return const Text('No hay documentos');
              }

              final goalAccounts = querySnapshot.docs.map((e) => e.data()).toList();
              
              return Column(
                children: [
                  const CustomDivider(title: 'Resumen de metas'),
                  Visibility(
                    visible: goalAccounts.isEmpty,
                    child: const CustomDivider(title: "Vacío", showLines: false),
                    ),
                  SizedBox(
                    height: 280,
                    child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: goalAccounts.length,
                          itemBuilder: (context, index) {
                              double goal = goalAccounts[index].goalAmount;
                              double collected = getGoalCollected(user.id, goalAccounts[index].goalId);
                              return SizedBox(
                                width: 300,
                                child: GoalCard(
                                  title: goalAccounts[index].goalName,
                                  row1: 'Objetivo:',
                                  row2: 'Reunido:',
                                  row3: 'Restante:',
                                  money1: goal,
                                  money2: collected,
                                  money3: goal - collected,
                                  onTap: (){
                                    Navigator.pushNamed(context, 
                                      '/accountdetails', 
                                      arguments: [goalAccounts[index].accountType, goalAccounts[index].goalId, goalAccounts[index].goalName]);
                                  },
                                  showLeadingButton: true,
                                ),
                              );
                          
                          },
                        ),
                  ),
                ],
              );

            },
          ),


          // const CustomDivider(title: 'Resumen de metas'),
          // Visibility(
          //   visible: goalAccounts.isEmpty,
          //   child: const CustomDivider(title: "Vacío", showLines: false),
          //   ),
          // SizedBox(
          //   height: 280,
          //   child: ListView.builder(
          //         scrollDirection: Axis.horizontal,
          //         itemCount: goalAccounts.length,
          //         itemBuilder: (context, index) {
          //             double goal = goalAccounts[index].goalAmount;
          //             double collected = getGoalCollected(user.id, goalAccounts[index].goalId);
          //             return SizedBox(
          //               width: 300,
          //               child: GoalCard(
          //                 title: goalAccounts[index].goalName,
          //                 row1: 'Objetivo:',
          //                 row2: 'Reunido:',
          //                 row3: 'Restante:',
          //                 money1: goal,
          //                 money2: collected,
          //                 money3: goal - collected,
          //                 onTap: (){
          //                   Navigator.pushNamed(context, 
          //                     '/accountdetails', 
          //                     arguments: [goalAccounts[index].accountType, goalAccounts[index].goalId, goalAccounts[index].goalName]);
          //                 },
          //                 showLeadingButton: true,
          //               ),
          //             );
                    
          //         },
          //       ),
          // ),

          

          // const CustomDivider(title: 'Actividades recientes'),
          // Visibility(
          //   visible: allRegistries.isEmpty,
          //   child: const CustomDivider(title: "Vacío", showLines: false),
          //   ),
          // Expanded(
          //   child: ListView.builder(
          //   itemCount: allRegistries.length,
          //   itemBuilder: (context, index) {
          //       String? accountName = getAccountNameById(allRegistries[index].accountId);
          //       return RecentActivityTile(
          //       title: allRegistries[index].title,
          //       description: allRegistries[index].description,
          //       account: accountName,  
          //       amount: allRegistries[index].amount,
          //       isDeposit: allRegistries[index].isDeposit,
          //       onTap: (){
          //         Navigator.pushNamed(context, '/registrydetails', arguments: allRegistries[index]);
          //       },
          //     );
              
          //   },
          // ),
          //),
          

        ],
      ),

          
      
      floatingActionButton: Visibility(
        //TODO: Hacer que el boton flotante sea visible solo si el usuario esta logeado
        visible: true,
        child: FloatingActionButton(
          onPressed: (){
            //TODO:Poner la navegacion a la pagina de agregar registro
          },
          backgroundColor: CustomColors.black,
          child: const Icon(Icons.add, color: CustomColors.white,)
        ),
      ),
    );
  }
}

