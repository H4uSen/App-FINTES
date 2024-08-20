import 'package:app_fintes/business_logic/data/globals.dart';
import 'package:app_fintes/business_logic/models/goal_model.dart';
import 'package:app_fintes/business_logic/models/registry_model.dart';
import 'package:app_fintes/business_logic/models/user_model.dart';
import 'package:app_fintes/business_logic/registry_functions.dart';
import 'package:app_fintes/business_logic/utilitity_functions.dart';
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
  
  bool isNewActive = false;

  @override
  Widget build(BuildContext context) {
  setSelectedDrawerOption('Inicio');
  final registriesRef = FirebaseFirestore.instance.collection('Registries');
  if(globalUser == null) {
    Navigator.pushReplacementNamed(context, '/principal');
  }

  User user = globalUser!;

  bool hasRegistries = false;
    

    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title:  const Text(
          'Inicio',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const CustomDivider(title: 'Resumen de metas'),
          FutureBuilder(
            //future: fetchData(user.id),
            future: fetchGoalData(),
            builder: (context, snapshot) {
              double emptyHeight =0;
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator());
              }
              if(snapshot.hasError){
                return const Center(child: Text('Error al cargar las metas'));
              }
              final data = snapshot.data;

              if (data == null) {
                return const Text('No hay documentos');
              }

              final goalAccounts = data['goals'] as List<Goal>;
              emptyHeight = goalAccounts.isEmpty ? 100 : 265;
              
              return SizedBox(
                height: emptyHeight,
                child: Column(
                  children: [
                    
                    Visibility(
                      visible: goalAccounts.isEmpty,
                      child: const CustomDivider(title: "Vacío", showLines: false),
                      ),
                    SizedBox(
                      height: emptyHeight,
                      child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: goalAccounts.length,
                            itemBuilder: (context, index) {
                                double goal = goalAccounts[index].goalAmount;
                                double collected = goalAccounts[index].goalCollected;
                                return SizedBox(
                                  width: 400,
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
                                        setSelectedDrawerOption(goalAccounts[index].goalName);
                                        setState(() {
                                          
                                        });
                                    },
                                    showLeadingButton: true,
                                  ),
                                );
                            
                            },
                          ),
                    ),
                  ],
                ),
              );

            },
          ),

          const CustomDivider(title: 'Actividades recientes'),
          Visibility(
            visible: hasRegistries,
            child: const CustomDivider(title: "Vacío", showLines: false),
            ),
          FutureBuilder(
            future: fetchRegData(), 
            builder:(context, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator());
              }
              if(snapshot.hasError){
                return const Center(child: Text('Error al cargar los registros'));
              }
              final data = snapshot.data;

              if (data == null) {
                return const Text('No hay documentos');
              }

              final allRegistries = data['registries'] as List<Registry>;
              hasRegistries = allRegistries.isNotEmpty;


              return Expanded(
                child: ListView.builder(
                itemCount: allRegistries.length,
                itemBuilder: (context, index) {
                  allRegistries[index].comesFrom = '/home';
                    String? accountName = allRegistries[index].accountName;
                    return RecentActivityTile(
                    title: allRegistries[index].title,
                    description: allRegistries[index].description,
                    account: accountName,  
                    amount: allRegistries[index].amount,
                    isDeposit: allRegistries[index].isDeposit,
                    onTap: (){
                      Navigator.pushNamed(context, '/registrydetails', arguments: allRegistries[index]);
                    },
                  );
                
                },
              ),
              );
              
            }),
        ],
      ),
          
      
      
      floatingActionButton: FutureBuilder(
        future: registriesRef.where('ownerId', isEqualTo: user.id).get(),
        builder: (context, snapshot) {
          snapshotValidation(snapshot);
          if(snapshot.hasData){
            final data = snapshot.data as QuerySnapshot;
            hasRegistries = data.docs.isNotEmpty;
          }
          return Visibility(
            visible: hasRegistries,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/newregistry');
              },
              backgroundColor: CustomColors.black,
              child: const Icon(Icons.add, color: CustomColors.white,)
            ),
          );
        }
      ),
    );
  }
}

Future<Map<String, dynamic>> fetchGoalData() async{
  final registriesRef = FirebaseFirestore.instance.collection('Registries');
  final goalsRef = FirebaseFirestore.instance.collection('Goals'); 
  List<Goal> goals = [];
  List<Registry> allRegistries = [];

  await goalsRef.where('ownerId', isEqualTo: globalUser!.id).get().then((value) async{
    for (var doc in value.docs){
      Goal goal = Goal.fromJson(doc.data(), doc.id);
      goals.add(goal);
    }
  }).catchError((error){}).whenComplete(()async{
    await registriesRef
    .where("ownerId",isEqualTo: globalUser!.id)
    .where('accountType', isEqualTo: AccountType.goal)
    .get().then((value) async{
      for (var doc in value.docs){
        Registry registry = Registry.fromJson(doc.data(), doc.id);
        allRegistries.add(registry);
      }
    }).catchError((error){}).whenComplete((){
      for(var goal in goals){
        double deposits = 0;
        double withdrawals = 0;
        for (var registry in allRegistries){
          if(registry.accountId == goal.goalId){
            if(registry.isDeposit) {
              deposits += registry.amount;
            } else {
              withdrawals += registry.amount;
            }
          }
        }
        goal.goalCollected = deposits - withdrawals;
      }
    });
  });
  
  
  return {'goals': goals};
}


Future<Map<String, dynamic>> fetchRegData() async{
  final registriesRef = FirebaseFirestore.instance.collection('Registries');
  List<Registry> allRegistries = [];

  await registriesRef
  .where("ownerId",isEqualTo: globalUser!.id)
  .orderBy("date",descending: true)
  .limit(20)
  .get()
  .then((value) async{
      for (var doc in value.docs){
        Registry registry = Registry.fromJson(doc.data(), doc.id);
        final accountName = await getAccountName(registry.accountId,registry.accountType);
        registry.accountName = accountName;
        allRegistries.add(registry);
      }
    }).catchError((error){});
  return {"registries": allRegistries};
}
