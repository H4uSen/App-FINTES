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
  final registriesRef = FirebaseFirestore.instance.collection('Registries');

    
  if(globalUser == null) {
    Navigator.pushReplacementNamed(context, '/principal');
  }
  User user = globalUser!;

  //bool hasGoals = false;
  bool hasRegistries = false;

  
Future<Map<String, dynamic>> fetchData (String userId) async {
  
  final goalsRef = FirebaseFirestore.instance.collection('Goals');
  //final registriesRef = FirebaseFirestore.instance.collection('Registries');
    List<Goal> goals = [];
    List<Registry> allRegistries = [];
    
    
    await goalsRef.where('ownerId', isEqualTo: userId).get().then((value) async{
      for (var doc in value.docs){
        Goal goal = Goal.fromJson(doc.data(), doc.id);
        goals.add(goal);
      }
    }).catchError((error){});

    await registriesRef.where("ownerId",isEqualTo: globalUser!.id).get().then((value) async{
      for (var doc in value.docs){
        Registry registry = Registry.fromJson(doc.data(), doc.id);
        final accountName = await getAccountName(registry.accountId,registry.accountType);
        registry.accountName = accountName;
        allRegistries.add(registry);
      }
    }).catchError((error){});

    //Para traer el monto reunido de las metas
    for(var goal in goals){
      await registriesRef.where('ownerId', isEqualTo: userId).where('accountId', isEqualTo: goal.goalId).get()
        .then((value) {
          double deposits = 0;
          double withdrawals = 0;
          for (var doc in value.docs){
            Registry registry = Registry.fromJson(doc.data(), doc.id);
            if(registry.isDeposit) {
              deposits += registry.amount;
            } else {
              withdrawals += registry.amount;
            }
          }
          goal.goalCollected = deposits - withdrawals;
        })
        .catchError((error){});
    }

    //hasGoals = goals.isNotEmpty;
    //hasRegistries = allRegistries.isNotEmpty;

    return {'goals': goals, 'registries': allRegistries};
  }
    

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
            future: fetchData(user.id),
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
              hasRegistries = data['registries'].isNotEmpty;
              final goalAccounts = data['goals'] as List<Goal>;
              //hasGoals = goalAccounts.isNotEmpty;
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
            future: fetchData(user.id), 
            builder:(context, snapshot){
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

