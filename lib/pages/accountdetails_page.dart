import 'package:app_fintes/business_logic/data/globals.dart';
import 'package:app_fintes/business_logic/models/account_model.dart';
import 'package:app_fintes/business_logic/data/registries_data.dart';
import 'package:app_fintes/business_logic/data_functions.dart';
import 'package:app_fintes/business_logic/models/registry_model.dart';
import 'package:app_fintes/pages/drawer.dart';
import 'package:app_fintes/widgets/drawer/divider.dart';
import 'package:app_fintes/widgets/home/goal_card.dart';
import 'package:app_fintes/widgets/home/recentactivity_tile.dart';
import 'package:flutter/material.dart';
import '../business_logic/data/accounts_data.dart';

class AccountDetailsPage extends StatelessWidget {
  const AccountDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    if(globalUser == null) {
    Navigator.pushReplacementNamed(context, '/principal');
    }

    Account account = ModalRoute.of(context)!.settings.arguments as Account;
    String accountType = ((account.accountType == AccountType.goal)?"Meta":(account.accountType == AccountType.account)?"Cuenta":"Pago");
    List<Registry> accountRegistries = getAccountRegistries(globalUser!.id, account.accountId);
    String row1, row2, row3;
    if(AccountType.goal == account.accountType){
      row1 = 'Objetivo:';
      row2 = 'Reunido:';
      row3 = 'Restante:';
    } else if (AccountType.account == account.accountType){
      row1 = 'Depositos:';
      row2 = 'Retiros:';
      row3 = 'Saldo:';
    } else {
      row1 = 'Pago:';
      row2 = 'Pagos realizados:';
      row3 = 'Total pagado:';
    }
    
    double deposits = getAccountDeposits(globalUser!.id, account.accountId);
    double withdrawals = getAccountWithdrawals(globalUser!.id, account.accountId);
    double balance = deposits - withdrawals;

    if(account.accountType == AccountType.recurrentPayment){
      deposits = account.recurrentAmount!;
      withdrawals = getAccountRegistries(globalUser!.id, account.accountId).length*1.00;
      balance = getAccountWithdrawals(globalUser!.id , account.accountId);
    }
    
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: Text(
          account.accountName,
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
            currency2: (account.accountType == AccountType.recurrentPayment)?false:true,
            showLeadingButton: false,
            ),

            const CustomDivider(title: "Actividad reciente"),
            Expanded(
              child: ListView.builder(
                itemCount: accountRegistries.length,
                itemBuilder: (context, index) {
                  return RecentActivityTile(
                    account: accountType,
                    title: accountRegistries[index].title,
                    description: accountRegistries[index].description,
                    amount: accountRegistries[index].amount,
                    isDeposit: accountRegistries[index].isDeposit,
                    
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}