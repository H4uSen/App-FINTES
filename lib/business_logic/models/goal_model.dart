
import 'package:app_fintes/business_logic/data/globals.dart';

class Goal {
  final String goalId;
  final String goalName;
  final double goalAmount;
  final String ownerId;
  final String accountType = AccountType.goal;
  const Goal({
    required this.ownerId,
    this.goalId ="",
    required this.goalName,
    required this.goalAmount,
  });

  factory Goal.fromJson(Map<String, dynamic> json, String id) {
    return Goal(
      ownerId: json['ownerId'],
      goalId: id,
      goalName: json['goalName'],
      goalAmount: json['goalAmount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ownerId': ownerId,
      'goalName': goalName,
      'goalAmount': goalAmount,
    };
  }
}