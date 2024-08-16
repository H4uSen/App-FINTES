import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String drawerOptionSelected = 'Inicio';
String getSelectedDrawerOption() {
  return drawerOptionSelected;
}
void setSelectedDrawerOption(String drawerOption) {
  drawerOptionSelected = drawerOption;
}
String transactionSymbol (bool isDeposit) {
  return isDeposit ? '+' : '-';
}
String fixedCurrency ( double amount, [String? currency]) {
  if(currency == null || currency.isEmpty) {
    return amount.toStringAsFixed(2);
  }else {
    return '$currency ${amount.toStringAsFixed(2)}';
  }
}

Widget? snapshotValidation(AsyncSnapshot snapshot) {
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
  return null;
}

String formattedDate(DateTime date) {
  var formatter = DateFormat('dd/MM/yyyy');
  return formatter.format(date);
}

