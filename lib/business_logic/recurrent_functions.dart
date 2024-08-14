
import 'package:app_fintes/business_logic/models/recurrent_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List<RecurrentPayment> getUserRecurrents(String userId) {
  List<RecurrentPayment> recurrents = [];
  FirebaseFirestore.instance.collection('Recurrents')
    .where('ownerId', isEqualTo: userId)
    .get()
    .then((value) {
      for (var doc in value.docs){
        RecurrentPayment recurrent = RecurrentPayment.fromJson(doc.data(), doc.id);
        recurrents.add(recurrent);
      }
    })
    .catchError((error){});
  return recurrents;
}

double getRecurrentDeposits (String userId, String recurrentId) {
  double deposits = 0;
  FirebaseFirestore.instance.collection('Registries')
    .where('ownerId', isEqualTo: userId)
    .where('accountId', isEqualTo: recurrentId)
    .get()
    .then((value) {
      for (var doc in value.docs){
        RecurrentPayment recurrent = RecurrentPayment.fromJson(doc.data(), doc.id);
        if(recurrent.isDeposit) {
          deposits += recurrent.recurrentAmount;
        }
      }
    })
    .catchError((error){});
  return deposits;
}

double getRecurrentWithdrawals (String userId, String recurrentId) {
  double withdrawals = 0;
  FirebaseFirestore.instance.collection('Registries')
    .where('ownerId', isEqualTo: userId)
    .where('accountId', isEqualTo: recurrentId)
    .get()
    .then((value) {
      for (var doc in value.docs){
        RecurrentPayment recurrent = RecurrentPayment.fromJson(doc.data(), doc.id);
        if(!recurrent.isDeposit) {
          withdrawals += recurrent.recurrentAmount;
        }
      }
    })
    .catchError((error){});
  return withdrawals;
}
