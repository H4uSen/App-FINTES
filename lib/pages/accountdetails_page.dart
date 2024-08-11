import 'package:app_fintes/business_logic/models/account_model.dart';
import 'package:app_fintes/business_logic/data/registries_data.dart';
import 'package:app_fintes/business_logic/data_functions.dart';
import 'package:app_fintes/business_logic/models/registry_model.dart';
import 'package:app_fintes/widgets/drawer/divider.dart';
import 'package:app_fintes/widgets/home/goal_card.dart';
import 'package:app_fintes/widgets/home/recentactivity_tile.dart';
import 'package:flutter/material.dart';
import '../business_logic/data/accounts_data.dart';

class AccountDetailsPage extends StatelessWidget {
  const AccountDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Account account = ModalRoute.of(context)!.settings.arguments as Account;
    
    String accountType = ((account.accountType == AccountType.goal)?"Meta":(account.accountType == AccountType.account)?"cuenta":"Pagos").toLowerCase();
    List<Registry> accountRegistries = registries.where((e) => e.account.accountName == account.accountName).toList();
    double deposits = getAccountDeposits(registries, account.accountName);
    double withdrawals = getAccountWithdrawals(registries, account.accountName);
    double balance = deposits - withdrawals;
    
    return Scaffold(
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
            row1: 'Ingresos:',
            row2: 'Egresos:',
            row3: 'Saldo:',
            money1: deposits,
            money2: withdrawals,
            money3: balance,
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