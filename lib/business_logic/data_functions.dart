

import 'package:app_fintes/business_logic/models/account_model.dart';
import 'package:app_fintes/business_logic/models/registry_model.dart';

List<Account> getUserAccounts(List<Account> accounts, String userId) {
  List<Account> userAccounts = [];
  for(var account in accounts) {
    (account.owner == userId && account.accountType == AccountType.account)?userAccounts.add(account):null;
  }
  return userAccounts;
}

List<Account> getAccountGoals(List<Account> accounts) {
  List<Account> goals = [];
  for(var account in accounts) {
    (account.accountType == AccountType.goal)?goals.add(account):null;
  }
  return goals;
}

List<Account> getAccountRecurrents(List<Account> accounts) {
  List<Account> savings = [];
  for(var account in accounts) {
    (account.accountType == AccountType.recurrentPayment)?savings.add(account):null;
  }
  return savings;
}

List<Registry> getAccountRegistries(List<Registry> registries, String accountName) {
  List<Registry> accountRegistries = [];
  for(var registry in registries) {
    (registry.account.accountName == accountName)?accountRegistries.add(registry):null;
  }
  return accountRegistries;
}



double getAccountCollected(List<Registry> goalRegistries, String goalAccountName) {
  double collected = 0;
  for(var goal in goalRegistries) {
    (goal.account.accountName == goalAccountName)?collected += goal.amount:null;
  }
  return collected;
}

double getAccountDeposits(List<Registry> accountRegistries, String accountName) {
  double deposits = 0;
  for(var account in accountRegistries) {
    (account.account.accountName == accountName && account.isDeposit)?deposits += account.amount:null;
  }
  return deposits;
}
double getAccountWithdrawals(List<Registry> accountRegistries, String accountName) {
  double withdrawals = 0;
  for(var account in accountRegistries) {
    (account.account.accountName == accountName && !account.isDeposit)?withdrawals += account.amount:null;
  }
  return withdrawals;
}

String transactionSymbol (bool isDeposit) {
  return isDeposit ? '+' : '-';
}

String fixedCurrency ( double amount, [String? currency]) {
  if(currency == null) {
    return amount.toStringAsFixed(2);
  }else {
    return '$currency ${amount.toStringAsFixed(2)}';
  }
}

