import 'dart:ffi';

import 'package:app_fintes/business_logic/data/globals.dart';
import 'package:app_fintes/business_logic/models/registry_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

List<Registry> getAccountRegistries(String userId, String accountId) {
  List<Registry> registries = [];
  FirebaseFirestore.instance.collection('Registries')
    .where('ownerId', isEqualTo: userId)
    .where('accountId', isEqualTo: accountId)
    .get()
    .then((value) {
      for (var doc in value.docs){
        Registry registry = Registry.fromJson(doc.data(), doc.id);
        registries.add(registry);
      }
    })
    .catchError((error){});
  return registries;
}

double getAccountDeposits (String userId, String accountId) {
  double deposits = 0;
  FirebaseFirestore.instance.collection('Registries')
    .where('ownerId', isEqualTo: userId)
    .where('accountId', isEqualTo: accountId)
    .get()
    .then((value) {
      for (var doc in value.docs){
        Registry registry = Registry.fromJson(doc.data(), doc.id);
        if(registry.isDeposit) {
          deposits += registry.amount;
        }
      }
    })
    .catchError((error){});
  return deposits;
}

double getAccountWithdrawals (String userId, String accountId) {
  double withdrawals = 0;
  FirebaseFirestore.instance.collection('Registries')
    .where('ownerId', isEqualTo: userId)
    .where('accountId', isEqualTo: accountId)
    .get()
    .then((value) {
      for (var doc in value.docs){
        Registry registry = Registry.fromJson(doc.data(), doc.id);
        if(!registry.isDeposit) {
          withdrawals += registry.amount;
        }
      }
    })
    .catchError((error){});
  return withdrawals;
}

List<Registry> getAllUserRegistries (String userId) {
  List<Registry> registries = [];
  FirebaseFirestore.instance.collection('Registries')
    .where('ownerId', isEqualTo: userId)
    .get()
    .then((value) {
      for (var doc in value.docs){
        Registry registry = Registry.fromJson(doc.data(), doc.id);
        registries.add(registry);
      }
    })
    .catchError((error){});
  return registries;
}

String getAccountNameById (String accountId) {
  String accountName = '';
  FirebaseFirestore.instance.collection('Accounts')
    .doc(accountId)
    .get()
    .then((value) {
      accountName = value.data()!['name'];
      if(accountName.isEmpty){
        return accountName;
      }
    });

    FirebaseFirestore.instance.collection('Goals')
    .doc(accountId)
    .get()
    .then((value) {
      accountName = value.data()!['name'];
      if(accountName.isEmpty){
        return accountName;
      }
    });

    FirebaseFirestore.instance.collection('Recurrents')
    .doc(accountId)
    .get()
    .then((value) {
      accountName = value.data()!['name'];
      if(accountName.isEmpty){
        return accountName;
      }
    });
  return accountName;
}

Future<String> getAccountName (String accountId,String type) async {
  String accountName = '';
  String collection = type == AccountType.account ? 'Accounts' : type == AccountType.goal ? 'Goals' : 'Recurrents';
  await FirebaseFirestore.instance.collection(collection)
    .where('type', isEqualTo: type)
    .get()
    .then((value) {
      accountName = value.docs.first.data()["name"].toString();
    });
  return accountName;
}



Future<bool> deleteRegistry(String registryId) async {
  FirebaseFirestore.instance.collection('Registries')
    .doc(registryId)
    .delete()
    .then((value) {
      return true;
    })
    .catchError((error){
      return false;
    });
  return false;
}

Future<bool> updateRegistry(Registry registry) async {
  FirebaseFirestore.instance.collection('Registries')
    .doc(registry.registryId)
    .update(registry.toJson())
    .then((value) {
      return true;
    })
    .catchError((error){
      return false;
    });
  return false;
}