

import 'package:app_fintes/business_logic/data/globals.dart';

class RecurrentPayment {
  final String recurrentId;
  final String recurrentName;
  final double recurrentAmount;
  final bool isDeposit;
  final String ownerId;
  final String accountId;
  final String accountType = AccountType.recurrentPayment;

  const RecurrentPayment({
    required this.accountId,
    required this.ownerId,
    required this.isDeposit,
    this.recurrentId = "",
    required this.recurrentName,
    required this.recurrentAmount,
  });

  factory RecurrentPayment.fromJson(Map<String, dynamic> json, String id) {
    return RecurrentPayment(
      accountId: json['accountId'],
      ownerId: json['ownerId'],
      recurrentId: id,
      recurrentName: json['recurrentName'],
      recurrentAmount: json['recurrentAmount'],
      isDeposit: json['isDeposit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accountId': accountId,
      'ownerId': ownerId,
      'recurrentName': recurrentName,
      'recurrentAmount': recurrentAmount,
      'isDeposit': isDeposit,
    };
  }
}