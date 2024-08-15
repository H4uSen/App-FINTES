
import 'package:app_fintes/business_logic/models/goal_model.dart';
import 'package:app_fintes/business_logic/models/registry_model.dart';
import 'package:app_fintes/business_logic/registry_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List<Goal> getUserGoals(String userId)  {
  List<Goal> goals = [];
  FirebaseFirestore.instance.collection('Goals')
    .where('ownerId', isEqualTo: userId)
    .get()
    .then((value) {
      for (var doc in value.docs){
        Goal goal = Goal.fromJson(doc.data(), doc.id);
        goals.add(goal);
      }
    })
    .catchError((error){});
  return goals;
}

Future<List<Goal>> getUserGoalsTest(String userId)  async {
  List<Goal> goals = [];
  FirebaseFirestore.instance.collection('Goals')
    .where('ownerId', isEqualTo: userId)
    .get()
    .then((value) {
      for (var doc in value.docs){
        Goal goal = Goal.fromJson(doc.data(), doc.id);
        goals.add(goal);
      }
      return goals;
    })
    .catchError((error){return goals;});
  return goals;
}


Future<double> getGoalCollected (String userId, String goalId) async {
  double collected = 0;
  collected = getAccountDeposits(userId, goalId);
  collected -= getAccountWithdrawals(userId, goalId);
  return collected;
}

