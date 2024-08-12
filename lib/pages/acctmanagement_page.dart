// pages/acctmanagement_page.dart
import 'package:app_fintes/business_logic/data/globals.dart';
import 'package:app_fintes/business_logic/data_functions.dart';
import 'package:app_fintes/business_logic/models/account_model.dart';
import 'package:app_fintes/widgets/acct_listtile.dart';
import 'package:app_fintes/widgets/form/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:app_fintes/widgets/theme_config.dart'; 
import 'package:app_fintes/widgets/drawer/divider.dart';

class GestionCuentas extends StatelessWidget {
  const GestionCuentas({super.key});

  @override
  Widget build(BuildContext context) {
    List<Account> accounts = getUserAccounts(globalUser!.id);
    List<Account> goals = getUserGoals(globalUser!.id);
    List<Account> recurrents = getUserRecurrents(globalUser!.id);
    bool hasRecurrents = recurrents.isEmpty;
    bool hasGoals = goals.isEmpty;
    bool hasAccounts = accounts.isEmpty;

    //TODO: Hay que hacer que funcionen los botones de editar, eliminar y añadir
    return Scaffold(
      appBar:  AppBar(
        title: const Text('Ajustes de la cuenta'),
        backgroundColor: CustomColors.lightBlue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomDivider(
              title: 'Cuentas',
              showLines: true,
            ),
            const SizedBox(height: 15),

            for (var account in accounts)
              AcctListtile(
                title: account.accountName,
                leadingIcon: Icons.attach_money,
                editIcon: Icons.edit,
                deleteIcon: Icons.delete,
                onEdit: () {
                  // 
                },
                onDelete: () {
                  // 
                },
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
              label: 'Añadir Cuenta',
              onPressed: () {
                // 
              },
            ),
            
            const CustomDivider(
              title: 'Metas',
              showLines: true,
            ),
            const SizedBox(height: 15),

            for (var goal in goals)
              AcctListtile(
                title: goal.accountName,
                leadingIcon: Icons.flag,
                leadingIconBackgroundColor: CustomColors.yellow,
                editIcon: Icons.edit,
                deleteIcon: Icons.delete,
                onEdit: () {
                  // 
                },
                onDelete: () {
                  // 
                },
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
              label: 'Añadir Meta',
              onPressed: () {
                // 
              },
            ),
            const CustomDivider(
              title: 'Pagos recurrentes',
              showLines: true,
            ),
            const SizedBox(height: 15),
            for (var recurrent in recurrents)
              AcctListtile(
                title: recurrent.accountName,
                leadingIcon: Icons.lock_clock,
                leadingIconBackgroundColor: CustomColors.red,
                editIcon: Icons.edit,
                deleteIcon: Icons.delete,
                onEdit: () {
                  // 
                },
                onDelete: () {
                  // 
                },
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
              label: 'Añadir Pago Recurrente',
              onPressed: () {
                // 
              },
            ),
            const SizedBox(height: 15),
            ],
        ),
      ),
    );
  }
}