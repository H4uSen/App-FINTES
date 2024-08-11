import 'package:app_fintes/business_logic/models/account_model.dart';
import 'package:app_fintes/business_logic/models/registry_model.dart';

List<Registry> getAccountRegistries(List<Registry> registries,String accountName) {
    for(var registry in registries) {
      (registry.account.accountName == accountName)?registries.add(registry):null;
    }
    return registries;
  }



List<Account> accounts = const [
  Account(
    accountId: '1',
    accountName: 'Efectivo',
    accountType: AccountType.account,
    owner: '1',
  ),
  Account(
    accountId: '2',
    accountName: 'Tarjeta',
    accountType: AccountType.account,
    owner: '1',
  ),
  Account(
    accountId: '3',
    accountName: 'Ahorros',
    accountType: AccountType.account,
    owner: '1',
  ),
  Account(
    accountId: '4',
    accountName: 'Carro',
    accountType: AccountType.goal,
    goalAmount: 200000.00,
    owner: '1',
  ),
  Account(
    owner: '1',
    accountId: '5',
    accountName: 'Telefono',
    accountType: AccountType.goal,
    goalAmount: 24000.00,
  ),
  Account(
    owner: '1',
    accountId: '5',
    accountName: 'Netflix',
    accountType: AccountType.recurrentPayment,
    recurrentAmount: 250.00,
  ),

];

