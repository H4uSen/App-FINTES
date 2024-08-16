import 'package:app_fintes/business_logic/data/globals.dart';
import 'package:app_fintes/business_logic/models/account_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List<Account> getUserAccounts(String userId) {
  List<Account> accounts = [];
  FirebaseFirestore.instance.collection('Accounts')
    .where('ownerId', isEqualTo: userId)
    .get()
    .then((value) {
      for (var doc in value.docs){
        Account account = Account.fromJson(doc.data(), doc.id);
        accounts.add(account);
      }
    })
    .catchError((error){});
  return accounts;
}

Future<Account?> getAccountById (String accountId) async {
  Account? account;
  await FirebaseFirestore.instance.collection('Accounts')
    .doc(accountId)
    .get()
    .then((value) {
      account = Account.fromJson(value.data()!, value.id);
    })
    .catchError((error){});
  return account;
}

