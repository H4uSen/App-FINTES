import 'package:app_fintes/business_logic/models/account_model.dart';
import 'package:app_fintes/business_logic/models/user_model.dart';

class Registry {
  final String registryId;
  final String title;
  final String description;
  final Account account;
  final String owner;
  final double amount;
  final bool isDeposit;

  const Registry({
    required this.owner,
    required this.registryId,
    required this.title,
    required this.description,
    required this.account,
    required this.amount,
    required this.isDeposit,
  });
}