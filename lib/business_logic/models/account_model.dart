

import 'package:app_fintes/business_logic/models/registry_model.dart';
import 'package:app_fintes/business_logic/models/user_model.dart';

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

  final String owner;

  const Account({
    required this.owner,
    required this.accountId,
    required this.accountName,
    required this.accountType,

    this.recurrentAmount, 
    this.isDeposit, 
    this.goalAmount, 
  });

  getGoalCollected(List<Registry> goalsRegistries, String accountName) {}
}