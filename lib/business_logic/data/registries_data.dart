import 'package:app_fintes/business_logic/data/accounts_data.dart';
import 'package:app_fintes/business_logic/models/registry_model.dart';

List<Registry> registries = [
  Registry(
    registryId: '1',
    title: 'Dinero recibido por x cosa',
    description: 'este es un ejemplo de una actividad reciente con una descripción larga, me gustaria ver como se ve y que se ajuste de manera correcta en la pantalla',
    account: accounts.firstWhere((e) => e.accountName == 'Ahorros'),
    owner: '1',
    amount:  100000.00,
    isDeposit: true,
  ),
  Registry(
    registryId: '2',
    title: 'Compra X Amazon',
    description: 'este es un ejemplo de una actividad reciente con una descripción larga, me gustaria ver como se ve y que se ajuste de manera correcta en la pantalla',
    account: accounts.firstWhere((e) => e.accountName == 'Tarjeta'),
    owner: '1',
    amount: 500.12,
    isDeposit: false,
  ),
  Registry(
    registryId: '3',
    title: 'Dinero recibido por Y cosa',
    description: 'este es un ejemplo de una actividad reciente con una descripción larga, me gustaria ver como se ve y que se ajuste de manera correcta en la pantalla',
    owner: '1',
    account: accounts.firstWhere((e) => e.accountName == 'Efectivo'),
    amount: 100000.90,
    isDeposit: true,
  ),
  Registry(
    registryId: '4', 
    title: "Aporte para el carro", 
    description: "este es un ejemplo de una actividad reciente con una descripción larga, me gustaria ver como se ve y que se ajuste de manera correcta en la pantalla", 
    owner: '1',
    account: accounts.firstWhere((e) => e.accountName == 'Carro'), 
    amount: 12000.00, 
    isDeposit: true
    ),
  Registry(
    registryId: '5', 
    title: 'Telefono', 
    description: 'Este es un ejemplo de', 
    owner: '1',
    account: accounts.firstWhere((e) => e.accountName == 'Telefono'), 
    amount: 10000, 
    isDeposit: true),
  Registry(
    registryId: '6',
    title: 'Pago de Netflix',
    description: 'este es un ejemplo de una actividad reciente con una descripción larga, me gustaria ver como se ve y que se ajuste de manera correcta en la pantalla',
    amount: 250.59,
    owner: '1',
    account: accounts.firstWhere((e) => e.accountName == 'Netflix'),
    isDeposit: false,
  )
];