// pages/acctmanagement_page.dart
import 'package:app_fintes/business_logic/account_functions.dart';
import 'package:app_fintes/business_logic/data/globals.dart';
import 'package:app_fintes/business_logic/goal_functions.dart';
import 'package:app_fintes/business_logic/models/account_model.dart';
import 'package:app_fintes/business_logic/models/goal_model.dart';
import 'package:app_fintes/business_logic/models/recurrent_model.dart';
import 'package:app_fintes/business_logic/recurrent_functions.dart';
import 'package:app_fintes/widgets/acct_listtile.dart';
import 'package:app_fintes/widgets/form/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_fintes/widgets/theme_config.dart'; 
import 'package:app_fintes/widgets/drawer/divider.dart';

class GestionCuentas extends StatefulWidget {
  const GestionCuentas({super.key});

  @override
  State<GestionCuentas> createState() => _GestionCuentasState();
}

class _GestionCuentasState extends State<GestionCuentas> {

  @override
  Widget build(BuildContext context) {
    final accountRef = FirebaseFirestore.instance.collection('Accounts').where('ownerId', isEqualTo: globalUser!.id);
    final goalRef = FirebaseFirestore.instance.collection('Goals').where('ownerId', isEqualTo: globalUser!.id);
    final recurrentRef = FirebaseFirestore.instance.collection('Recurrents').where('ownerId', isEqualTo: globalUser!.id);
    List<Account> accounts = [];
    List<Goal> goals = [];
    List<RecurrentPayment> recurrents = [];
    bool hasRecurrents = recurrents.isNotEmpty;
    bool hasGoals = recurrents.isNotEmpty;
    bool hasAccounts = accounts.isNotEmpty;

    return Scaffold(
      appBar:  AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/home");
              
            }, 
            icon: const Icon(Icons.arrow_back)
          ),

        title: const Text('Ajustes de la cuenta'),
        backgroundColor: CustomColors.lightBlue,
      ),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomDivider(
                title: 'Cuentas',
                showLines: true,
              ),
              const SizedBox(height: 15),
                FutureBuilder(
                  future: accountRef.get(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
          
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
          
                    final querySnapshot = snapshot.data;
          
                    if (querySnapshot == null) {
                      return const Text('No hay documentos');
                    }
                    accounts = querySnapshot.docs.map((doc) => Account.fromJson(doc.data(), doc.id)).toList();
                    
                    List<Widget> accountTiles = [];
                    for (var account in accounts){
                      accountTiles.add(
                        AcctListtile(
                          title: account.accountName,
                          leadingIcon: Icons.attach_money,
                          editIcon: Icons.edit,
                          deleteIcon: Icons.delete,
                          onEdit: () {
                            updateAccountDialog(context, account).whenComplete(() {
                              setState(() {
                              });
                            });
                          },
                          onDelete: () {
                            deleteAccountDialog(context, account).whenComplete(() {
                              setState(() {
                              });
                            });
                            
                          },
                        )
                      );
                    }
                    return Column(
                      children: accountTiles,
                    );  
                  }
                ),
              Visibility(
                visible: hasAccounts,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: CustomDivider(title: 'Vacío', showLines: false),
                ),
              ),
              const SizedBox(height: 10),
              CustomOutlinedButton(
                label: 'Añadir cuenta',
                backgroundColor: CustomColors.darkBlue,
                onPressed: () {
                  createAccountDialog(context).whenComplete(() {
                    setState(() {
                    });
                  });
                  
                },
              ),
              
          
          
          
              const CustomDivider(
                title: 'Metas',
                showLines: true,
              ),
              const SizedBox(height: 15),
              FutureBuilder(
                future: goalRef.get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
          
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
          
                    final querySnapshot = snapshot.data;
          
                    if (querySnapshot == null) {
                      return const Text('No hay documentos');
                    }
                  goals = querySnapshot.docs.map((doc) => Goal.fromJson(doc.data(), doc.id)).toList();
                  List<Widget> accountTiles = [];
                  for (var account in goals){
                    accountTiles.add(
                      AcctListtile(
                        title: account.goalName,
                        leadingIcon: Icons.flag,
                        editIcon: Icons.edit,
                        deleteIcon: Icons.delete,
                        leadingIconBackgroundColor: CustomColors.yellow,
                        onEdit: () {
                          updateGoalDialog(context, account).whenComplete(() {
                            setState(() {
                            });
                          });
                        },
                        onDelete: () {
                          deleteGoalDialog(context, account).whenComplete(() {
                            setState(() {
                            });
                          });
                        },
                      )
                    );
                  }
          
                  return Column(
                    children: accountTiles,
                  );  
                }
              ),
              Visibility(
                  visible: hasGoals,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: CustomDivider(title: 'Vacío', showLines: false),
                  ),
                ),
          
              const SizedBox(height: 10),
              CustomOutlinedButton(
                label: 'Añadir meta',
                backgroundColor: CustomColors.darkBlue,
                
                onPressed: () {
                  createGoalDialog(context)
                  .whenComplete((){
                    setState(() {
                    });
                  });
                },
              ),
          
          
          
          
              const CustomDivider(
                title: 'Pagos recurrentes',
                showLines: true,
              ),
              const SizedBox(height: 15),
              FutureBuilder(
                future: recurrentRef.get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
          
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
          
                    final querySnapshot = snapshot.data;
          
                    if (querySnapshot == null) {
                      return const Text('No hay documentos');
                    }
                  recurrents = querySnapshot.docs.map((doc) => RecurrentPayment.fromJson(doc.data(), doc.id)).toList();
                  List<Widget> accountTiles = [];
                  for (var account in recurrents){
                    accountTiles.add(
                      AcctListtile(
                        title: account.recurrentName,
                        leadingIcon: Icons.flag,
                        editIcon: Icons.edit,
                        deleteIcon: Icons.delete,
                        leadingIconBackgroundColor: CustomColors.red,
                        onEdit: () {
                          updateRecurrentDialog(context, account).whenComplete(() {
                            setState(() {
                            });
                          });
                        },
                        onDelete: () {
                          deleteRecurrentDialog(context, account).whenComplete(() {
                            setState(() {
                            });
                          });
                        },
                      )
                    );
                  }
          
                  return Column(
                    children: accountTiles,
                  );  
                }
              ),
                Visibility(
                    visible: hasRecurrents,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: CustomDivider(title: 'Vacío', showLines: false),
                    ),
                  ),   
              const SizedBox(height: 10),
              CustomOutlinedButton(
                label: 'Añadir pago recurrente',
                backgroundColor: CustomColors.darkBlue,
                onPressed: () {
                  createRecurrentDialog(context).whenComplete(() {
                    setState(() {
                    });
                  });
                },
              ),
              const SizedBox(height: 15),
              ],
          ),
        ),
      ),
    );
  }


}