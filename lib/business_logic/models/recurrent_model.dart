

import 'package:app_fintes/business_logic/data/globals.dart';

class RecurrentPayment {
  final String recurrentId;
  final String recurrentName;
  final double recurrentAmount;
  final bool isDeposit;
  final String ownerId;
  final String accountId;
  String accountType;

  RecurrentPayment({
    this.accountId ="",
    this.accountType = AccountType.recurrentPayment,
    required this.ownerId,
    required this.isDeposit,
    this.recurrentId = "",
    required this.recurrentName,
    required this.recurrentAmount,
  });

  factory RecurrentPayment.fromJson(Map<String, dynamic> json, String id) {
    return RecurrentPayment(
      accountId: json['accountId'],
      accountType: json['type'],
      ownerId: json['ownerId'],
      recurrentId: id,
      recurrentName: json['name'].toString(),
      recurrentAmount: double.parse(json['amount'].toString()),
      isDeposit: json['isDeposit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accountId': accountId,
      'type': accountType,
      'ownerId': ownerId,
      'name': recurrentName,
      'amount': recurrentAmount,
      'isDeposit': isDeposit,

    };
  }
}