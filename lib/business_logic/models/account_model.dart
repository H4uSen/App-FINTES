
import 'package:app_fintes/business_logic/data/globals.dart';

class Account {
  final String accountId;
  final String accountName;
  final String ownerId;
  final String accountType;

  const Account({
    required this.ownerId,
    this.accountId ="",
    this.accountType = AccountType.account,
    required this.accountName,
  });

  factory Account.fromJson(Map<String, dynamic> json, String id) {
    return Account(
      accountId: id,
      accountType: AccountType.account,
      ownerId: json['ownerId'],
      accountName: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ownerId': ownerId,
      'name': accountName,
      'type': accountType,
    };
  }
  
}


