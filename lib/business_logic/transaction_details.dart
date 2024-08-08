String transactionSymbol (bool isDeposit) {
  return isDeposit ? '+' : '-';
}

String fixedCurrency (double amount, String currency) {
  return '$currency ${amount.toStringAsFixed(2)}';
}