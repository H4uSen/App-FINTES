import 'package:app_fintes/business_logic/transaction_details.dart';

List<Account> accounts = [
  Account(
    accountId: '1',
    accountName: 'Efectivo',
    accountType: AccountType.account,
  ),
  Account(
    accountId: '2',
    accountName: 'Tarjeta',
    accountType: AccountType.account,
  ),
  Account(
    accountId: '3',
    accountName: 'Ahorros',
    accountType: AccountType.account,
  ),
  Account(
    accountId: '4',
    accountName: 'Carro',
    accountType: AccountType.goal,
    goalAmount: 200000,
  ),
  Account(
    accountId: '5',
    accountName: 'Netflix',
    accountType: AccountType.recurrentPayment,
    recurrentAmount: 250,
  ),

];

List<RegistryDetails> registries = [
  RegistryDetails(
    registryId: '1',
    title: 'Dinero recibido por x cosa',
    description: 'este es un ejemplo de una actividad reciente con una descripción larga, me gustaria ver como se ve y que se ajuste de manera correcta en la pantalla',
    account: accounts.firstWhere((e) => e.accountName == 'Ahorros'),
    amount: 100000,
    isDeposit: true,
  ),
  RegistryDetails(
    registryId: '2',
    title: 'Compra X Amazon',
    description: 'este es un ejemplo de una actividad reciente con una descripción larga, me gustaria ver como se ve y que se ajuste de manera correcta en la pantalla',
    account: accounts.firstWhere((e) => e.accountName == 'Tarjeta'),
    amount: 500,
    isDeposit: false,
  ),
  RegistryDetails(
    registryId: '3',
    title: 'Dinero recibido por Y cosa',
    description: 'este es un ejemplo de una actividad reciente con una descripción larga, me gustaria ver como se ve y que se ajuste de manera correcta en la pantalla',
    account: accounts.firstWhere((e) => e.accountName == 'Efectivo'),
    amount: 100000,
    isDeposit: true,
  ),
  RegistryDetails(
    registryId: '4', 
    title: "Aporte para el carro", 
    description: "este es un ejemplo de una actividad reciente con una descripción larga, me gustaria ver como se ve y que se ajuste de manera correcta en la pantalla", 
    account: accounts.firstWhere((e) => e.accountName == 'Carro'), 
    amount: 3200, 
    isDeposit: true
    ),
  RegistryDetails(
    registryId: '5',
    title: 'Pago de Netflix',
    description: 'este es un ejemplo de una actividad reciente con una descripción larga, me gustaria ver como se ve y que se ajuste de manera correcta en la pantalla',
    amount: 250,
    account: accounts.firstWhere((e) => e.accountName == 'Netflix'),
    isDeposit: false,
  )
];