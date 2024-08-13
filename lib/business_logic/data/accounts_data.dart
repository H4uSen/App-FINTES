import 'package:app_fintes/business_logic/models/account_model.dart';

List<Account> accounts = const [
  Account(
    accountId: '1',
    accountName: 'Efectivo',
    accountType: AccountType.account,
    ownerId: '1',
  ),
  Account(
    accountId: '2',
    accountName: 'Tarjeta',
    accountType: AccountType.account,
    ownerId: '1',
  ),
  Account(
    accountId: '3',
    accountName: 'Ahorros',
    accountType: AccountType.account,
    ownerId: '1',
  ),
  Account(
    accountId: '4',
    accountName: 'Carro',
    accountType: AccountType.goal,
    goalAmount: 200000.00,
    ownerId: '1',
  ),
  Account(
    accountId: '5',
    ownerId: '1',
    accountName: 'Telefono',
    accountType: AccountType.goal,
    goalAmount: 24000.00,
  ),
  Account(
    ownerId: '1',
    accountId: '6',
    accountName: 'Netflix',
    accountType: AccountType.recurrentPayment,
    recurrentAmount: 250.00,
  ),
];

