

import 'package:app_fintes/business_logic/data/accounts_data.dart';
import 'package:app_fintes/business_logic/data/registries_data.dart';
import 'package:app_fintes/business_logic/models/account_model.dart';
import 'package:app_fintes/business_logic/models/registry_model.dart';

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



//Account related functions
List<Account> getUserAccounts(String userId) {
  List<Account> userAccounts = [];
  for(var account in accounts) {
    (account.ownerId == userId && account.accountType == AccountType.account)?userAccounts.add(account):null;
  }
  return userAccounts;
}
List<Account> getUserGoals(String userId) {
  List<Account> goals = [];
  for(var account in accounts) {
    (account.accountType == AccountType.goal && account.ownerId == userId)?goals.add(account):null;
  }
  return goals;
}
List<Account> getUserRecurrents(String userId) {
  List<Account> recurrents = [];
  for(var account in accounts) {
    (account.accountType == AccountType.recurrentPayment && account.ownerId == userId)?recurrents.add(account):null;
  }
  return recurrents;
}
double getAccountCollected(String userId, String accountId) {
  double collected = 0;
  List<Registry> accountRegistries = getAccountRegistries(userId, accountId);
  for(var goal in accountRegistries) {
    (goal.accountId == accountId)?collected += ((goal.isDeposit)?goal.amount:goal.amount*-1):null;
  }
  return collected;
}
double getAccountDeposits(String userId, String accountId) {
  double deposits = 0;
  List<Registry> accountRegistries = getAccountRegistries(userId, accountId);
  for(var account in accountRegistries) {
    (account.accountId == accountId && account.isDeposit)?deposits += account.amount:null;
  }
  return deposits;
}
double getAccountWithdrawals(String userId, String accountId) {
  double withdrawals = 0;
  List<Registry> accountRegistries = getAccountRegistries(userId, accountId);
  for(var account in accountRegistries) {
    (account.accountId == accountId && !account.isDeposit)?withdrawals += account.amount:null;
  }
  return withdrawals;
}
String? getAccountNameById(String accountId) {
  for(var account in accounts) {
    if(account.accountId == accountId) {
      return account.accountName;
    }
  }
  return null;
}



//Registry related functions
List<Registry> getAccountRegistries(String userId, String accountId) {
  List<Registry> accountRegistries = [];
  for(var registry in registries) {
    (userId == registry.ownerId &&registry.accountId == accountId)?accountRegistries.add(registry):null;
  }
  return accountRegistries;
}
//
List<Registry> getAllUserRegistries(String userId) {
  List<Registry> userRegistries = [];
  for(var registry in registries) {
    (registry.ownerId == userId)?userRegistries.add(registry):null;
  }
  return userRegistries;
}
bool addRegistry(Registry registry) {
  try{
    registries.add(registry);
    return true;
  }catch(e) {
    return false;
  }
}
bool updateRegistry(Registry registry) {
  try{
    for(var reg in registries) {
      if(reg.registryId == registry.registryId) {
        reg = registry;
        return true;
      }
    }
    return false;
  }catch(e) {
    return false;
  }
}
bool deleteRegistry(String registryId) {
  try{
    registries.removeWhere((element) => element.registryId == registryId);
    return true;
  }catch(e) {
    return false;
  }
} 




