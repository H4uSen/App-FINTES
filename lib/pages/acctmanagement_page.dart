// pages/acctmanagement_page.dart
import 'package:app_fintes/widgets/acct_listtile.dart';
import 'package:app_fintes/widgets/form/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:app_fintes/widgets/theme_config.dart'; 
import 'package:app_fintes/widgets/drawer/divider.dart';

class GestionCuentas extends StatelessWidget {
  const GestionCuentas({super.key});

  @override
  Widget build(BuildContext context) {
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
        
            AcctListtile(
              title: 'Efectivo',
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
            const SizedBox(height: 10),
           AcctListtile(
              title: 'Tarjeta',
              leadingIcon: Icons.credit_card,
              editIcon: Icons.edit,
              deleteIcon: Icons.delete,
              onEdit: () {
                // 
              },
              onDelete: () {
                // 
              },
            ),
            const SizedBox(height: 10),
           AcctListtile(
              title: 'Ahorro',
              leadingIcon: Icons.savings,
              editIcon: Icons.edit,
              deleteIcon: Icons.delete,
              onEdit: () {
                // 
              },
              onDelete: () {
                // 
              },
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
        
            AcctListtile(
              title: 'Efectivo',
              leadingIcon: Icons.star_border,
              editIcon: Icons.edit,
              deleteIcon: Icons.delete,
              leadingIconBackgroundColor: Colors.yellow, 
              leadingIconColor: Colors.black, 
              onEdit: () {
                // 
              },
              onDelete: () {
                //
              },
            ),
            const SizedBox(height: 10),
            AcctListtile(
              title: 'Tarjeta',
              leadingIcon: Icons.star_border, 
              editIcon: Icons.edit,
              deleteIcon: Icons.delete,
              leadingIconBackgroundColor: Colors.yellow, 
              leadingIconColor: Colors.black, 
              onEdit: () {
                // 
              },
              onDelete: () {
                // 
              },
            ),
            const SizedBox(height: 10),
             AcctListtile(
              title: 'Ahorro',
              leadingIcon: Icons.star_border, 
              editIcon: Icons.edit,
              deleteIcon: Icons.delete,
              leadingIconBackgroundColor: Colors.yellow, 
              leadingIconColor: Colors.black, 
              onEdit: () {
                // 
              },
              onDelete: () {
                // 
              },
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
        
            AcctListtile(
              title: 'Netflix',
              leadingIcon: Icons.calendar_today,
              editIcon: Icons.edit,
              deleteIcon: Icons.delete,
              leadingIconBackgroundColor: Colors.yellow, 
              leadingIconColor: Colors.black, 
              onEdit: () {
                // 
              },
              onDelete: () {
                //
              },
            ),
            const SizedBox(height: 10),
             AcctListtile(
              title: 'Renta',
              leadingIcon: Icons.calendar_today, 
              editIcon: Icons.edit,
              deleteIcon: Icons.delete,
              leadingIconBackgroundColor: Colors.yellow, 
              leadingIconColor: Colors.black, 
              onEdit: () {
                // 
              },
              onDelete: () {
                // 
              },
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