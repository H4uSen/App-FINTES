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

