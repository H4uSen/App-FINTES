
import 'package:app_fintes/business_logic/data/globals.dart';

class Goal {
  final String goalId;
  final String goalName;
  final double goalAmount;
  double goalCollected;
  final String ownerId;
  final String accountType;
  Goal({
    required this.ownerId,
    this.goalId ="",
    this.accountType = AccountType.goal,
    required this.goalName,
    required this.goalAmount,
    this.goalCollected = 0.0,
  });

  factory Goal.fromJson(Map<String, dynamic> json, String id) {
    
    return Goal(
      ownerId: json['ownerId'],
      goalId: id,
      goalName: json['name'],
      goalAmount: double.parse(json['amount'].toString()),
      accountType: AccountType.goal,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ownerId': ownerId,
      'name': goalName,
      'type': accountType,
      'amount': goalAmount,
    };
  }
}