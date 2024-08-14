import 'package:app_fintes/business_logic/data/globals.dart';
import 'package:app_fintes/business_logic/models/registry_model.dart';
import 'package:app_fintes/business_logic/recurrent_functions.dart';
import 'package:app_fintes/pages/drawer.dart';
import 'package:app_fintes/widgets/drawer/divider.dart';
import 'package:app_fintes/widgets/home/goal_card.dart';
import 'package:app_fintes/widgets/home/recentactivity_tile.dart';
import 'package:flutter/material.dart';

import '../business_logic/registry_functions.dart';

class AccountDetailsPage extends StatelessWidget {
  const AccountDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    if(globalUser == null) {
    Navigator.pushReplacementNamed(context, '/principal');
    }

    List<String> args = ModalRoute.of(context)!.settings.arguments as List<String>;
    String argAccountType = args[0];
    String argAccountId = args[1];
    String argAccountName = args[2];
    


    String accountType = ((argAccountType == AccountType.goal)?"Meta":(argAccountType == AccountType.account)?"Cuenta":"Pago");
    List<Registry> accountRegistries = getAccountRegistries(globalUser!.id, argAccountId);
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
      row2 = 'Pagos realizados:';
      row3 = 'Total pagado:';
    }
    
    double deposits = getAccountDeposits(globalUser!.id, argAccountId);
    double withdrawals = getAccountWithdrawals(globalUser!.id, argAccountId);
    double balance = deposits - withdrawals;

    if(argAccountType == AccountType.recurrentPayment){
      deposits = getRecurrentDeposits(globalUser!.id, argAccountId);
      withdrawals = getAccountRegistries(globalUser!.id, argAccountId).length*1.00;
      balance = getAccountWithdrawals(globalUser!.id , argAccountId);
    }
    
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
          GoalCard(
            title: "Resumen de $accountType", 
            row1: row1,
            row2: row2,
            row3: row3,
            money1: deposits,
            money2: withdrawals,
            money3: balance,
            currency2: (accountType == AccountType.recurrentPayment)?false:true,
            showLeadingButton: false,
            ),

            const CustomDivider(title: "Actividad reciente"),
            Expanded(
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
            ),
        ],
      ),
    );
  }
}