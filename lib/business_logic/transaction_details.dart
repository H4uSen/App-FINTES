import 'package:app_fintes/business_logic/dummy_data.dart';

String transactionSymbol (bool isDeposit) {
  return isDeposit ? '+' : '-';
}

String fixedCurrency (double amount, String currency) {
  return '$currency ${amount.toStringAsFixed(2)}';
}

class AccountType {
  static const String account = 'Account';
  static const String goal = 'Goal';
  static const String recurrentPayment = 'RecurrentPayment';
}

class Account {
  final String accountId;
  final String accountName;
  final String accountType;

  final double? recurrentAmount;
  final bool? isDeposit;
  final double? goalAmount;


  const Account({
    required this.accountId,
    required this.accountName,
    required this.accountType,

    this.recurrentAmount, 
    this.isDeposit, 
    this.goalAmount, 
  });





double getGoalCollected(List<RegistryDetails> goalRegistries, String goalAccountName) {
    double collected = 0;
    for(var goal in goalRegistries) {
      (goal.account.accountName == goalAccountName)?collected += goal.amount:null;
    }
    return collected;
  }
}
double getAccountDeposits(List<RegistryDetails> accountRegistries, String accountName) {
    double deposits = 0;
    for(var account in accountRegistries) {
      (account.account.accountName == accountName && account.isDeposit)?deposits += account.amount:null;
    }
    return deposits;
  }
double getAccountWithdrawals(List<RegistryDetails> accountRegistries, String accountName) {
    double withdrawals = 0;
    for(var account in accountRegistries) {
      (account.account.accountName == accountName && !account.isDeposit)?withdrawals += account.amount:null;
    }
    return withdrawals;
  }


class RegistryDetails {
  final String registryId;
  final String title;
  final String description;
  final Account account;
  final double amount;
  final bool isDeposit;

  const RegistryDetails({
    required this.registryId,
    required this.title,
    required this.description,
    required this.account,
    required this.amount,
    required this.isDeposit,
  });
}