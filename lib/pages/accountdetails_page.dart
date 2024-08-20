
import 'package:app_fintes/business_logic/data/globals.dart';
import 'package:app_fintes/business_logic/models/account_model.dart';
import 'package:app_fintes/business_logic/models/goal_model.dart';
import 'package:app_fintes/business_logic/models/recurrent_model.dart';
import 'package:app_fintes/business_logic/models/registry_model.dart';
import 'package:app_fintes/business_logic/registry_functions.dart';
import 'package:app_fintes/business_logic/utilitity_functions.dart';
import 'package:app_fintes/pages/drawer.dart';
import 'package:app_fintes/widgets/drawer/divider.dart';
import 'package:app_fintes/widgets/home/goal_card.dart';
import 'package:app_fintes/widgets/home/recentactivity_tile.dart';
import 'package:app_fintes/widgets/scaffoldmsgs.dart';
import 'package:app_fintes/widgets/theme_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class AccountDetailsPage extends StatefulWidget {
  const AccountDetailsPage({super.key});

  @override
  State<AccountDetailsPage> createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  
  @override
  Widget build(BuildContext context) {
    final registriesRef = FirebaseFirestore.instance.collection('Registries');

    if(globalUser == null) {
    Navigator.pushReplacementNamed(context, '/principal');
    }

    List<String> args = ModalRoute.of(context)!.settings.arguments as List<String>;
    String argAccountType = args[0];
    String argAccountId = args[1];
    String argAccountName = args[2];
    


    String accountType = ((argAccountType == AccountType.goal)?"Meta":(argAccountType == AccountType.account)?"Cuenta":"Pago");
    //List<Registry> accountRegistries = getAccountRegistries(globalUser!.id, argAccountId);
    String row1, row2, row3;
    if(AccountType.goal == argAccountType){
      row1 = 'Objetivo:';
      row2 = 'Reunido:';
      row3 = 'Restante:';
    } else if (AccountType.account == argAccountType){
      row1 = 'Depositos:';
      row2 = 'Retiros:';
      row3 = 'Saldo:';
    } else {
      row1 = 'Pago:';
      row2 = 'Cantidad de pagos:';
      row3 = 'Balance:';
    }
    
    Future<List<dynamic>> getAccountData(String userId, String accountId, String accountType) async {
      double deposits = 0;
      double withdrawals = 0;
      double balance = 0;
      int amountPayments = 0;
      dynamic account;
      String collectionName = (accountType == AccountType.goal)?"Goals":(accountType == AccountType.account)?"Accounts":"Recurrents";
      await registriesRef
      .where('ownerId', isEqualTo: userId)
      .where('accountId', isEqualTo: accountId)
      .orderBy("date", descending: true).get()
      .then((value) {
          amountPayments = value.docs.length;
          for (var doc in value.docs){
            Registry registry = Registry.fromJson(doc.data(), doc.id);
            if(registry.isDeposit) {
              deposits += registry.amount;
            } else {
              withdrawals += registry.amount;
            }
          }
          balance = deposits - withdrawals;
        })
        .catchError((error){});
        await FirebaseFirestore.instance.collection(collectionName).doc(accountId).get()
          .then((value) {
            if(value.data() != null){
              if(accountType == AccountType.goal){
                account = Goal.fromJson(value.data()!, value.id);
              }
              if(accountType == AccountType.account){
                account = Account.fromJson(value.data()!, value.id);
              }
              if(accountType == AccountType.recurrentPayment){
                account = RecurrentPayment.fromJson(value.data()!, value.id);
              }
            }
          })
          .catchError((error){});
      return [deposits, withdrawals, balance,amountPayments.toDouble(),account];
    }
    // double deposits = getAccountDeposits(globalUser!.id, argAccountId);
    // double withdrawals = getAccountWithdrawals(globalUser!.id, argAccountId);
    // double balance = deposits - withdrawals;

    // if(argAccountType == AccountType.recurrentPayment){
    //   deposits = getRecurrentDeposits(globalUser!.id, argAccountId);
    //   withdrawals = getAccountRegistries(globalUser!.id, argAccountId).length*1.00;
    //   balance = getAccountWithdrawals(globalUser!.id , argAccountId);
    // }
    
    return Scaffold(
      drawer: CustomDrawer(), 
      appBar: AppBar(
        title: Text(
          argAccountName,
        ),
        centerTitle: true,
      ),

      body: Column(
        children: [
          FutureBuilder(
            future: getAccountData(globalUser!.id, argAccountId, argAccountType),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator());
              }
              if(snapshot.hasError){
                return const Center(child: Text('Error al cargar los datos'));
              }
              final data = snapshot.data;
              if (data == null) {
                return const Text('No hay documentos');
              }
              double money1 = data[0];
              double money2 = data[1];
              double money3 = data[2];
              bool showCurrency2 = true;
              if(argAccountType == AccountType.recurrentPayment){
                RecurrentPayment recurrent = data[4];
                money1 = recurrent.recurrentAmount;
                money2 = data[3];
                money3 = data[2];
                showCurrency2 = false;
              }
              if(argAccountType == AccountType.goal){
                Goal goal = data[4];
                money1 = goal.goalAmount;
                money2 = data[0]-data[1];
                money3 = goal.goalAmount - data[2];
              }
              
              

              return GoalCard(
                title: "Resumen de $accountType", 
                row1: row1,
                row2: row2,
                row3: row3,
                money1: money1,
                money2: money2,
                money3: money3,
                currency2: showCurrency2,
                showLeadingButton: false,
                );
            }
          ),

            const CustomDivider(title: "Actividad reciente"),
            FutureBuilder(
              future: registriesRef.where('ownerId', isEqualTo: globalUser!.id).where('accountId', isEqualTo: argAccountId).get(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator());
                }
                if(snapshot.hasError){
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                final data = snapshot.data;

                if (data == null) {
                  return const Text('No hay documentos');
                }
                
                final accountRegistries = data.docs.map((doc) => Registry.fromJson(doc.data(), doc.id)).toList();

                return Expanded(
                  child: ListView.builder(
                    itemCount: accountRegistries.length,
                    itemBuilder: (context, index) {
                      String? accountName = argAccountName;
                      return RecentActivityTile(
                        account: accountName,
                        title: accountRegistries[index].title,
                        description: accountRegistries[index].description,
                        amount: accountRegistries[index].amount,
                        isDeposit: accountRegistries[index].isDeposit,
                        onTap: () => Navigator.pushNamed(context, '/registrydetails', arguments: accountRegistries[index])
                      );
                    },
                  ),
                );
              },
            ),
        ],
      ),
      
      floatingActionButton: Visibility(
        visible: true,
        child: FloatingActionButton(
          onPressed: () {
            if(argAccountType != AccountType.recurrentPayment){
              Navigator.pushNamed(context, '/newregistry', arguments: [argAccountId, argAccountType, argAccountName]);
            }else{
              final recurrentRef = FirebaseFirestore.instance.collection('Recurrents');
              recurrentRef.doc(argAccountId).get()
                .then((value) async{
                  if(value.data() != null){
                    RecurrentPayment recurrent = RecurrentPayment.fromJson(value.data()!, value.id);
                    Registry newRecurrent = Registry(
                      ownerId: globalUser!.id,
                      accountId: argAccountId,
                      accountType: AccountType.recurrentPayment,
                      title: "${recurrent.recurrentName}-${formattedDate(DateTime.now())}" ,
                      description: "Pago de ${recurrent.recurrentName}",
                      amount: recurrent.recurrentAmount,
                      isDeposit: recurrent.isDeposit,
                      date: formattedDate(DateTime.now())
                    );
                    await createRegistry(newRecurrent).then((val){
                        if(val){
                          successScaffoldMsg(context, "Registro guardado exitosamente");
                          setState(() {
                            
                          });
                        } else {
                          errorScaffoldMsg(context, "No se pudo guardar el registro");
                        }
                      });
                    
                  }
                })
                .catchError((error){});

            }
          },
          backgroundColor: CustomColors.black,
          child: const Icon(Icons.add, color: CustomColors.white,)
        ),
      ),
    );
  }
}