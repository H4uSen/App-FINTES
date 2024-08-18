import 'package:app_fintes/business_logic/data/globals.dart';
import 'package:app_fintes/business_logic/models/account_model.dart';
import 'package:app_fintes/widgets/scaffoldmsgs.dart';
import 'package:app_fintes/widgets/theme_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

Future<List<Account>> getAccounts(String userId) async {
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


  Future<dynamic> updateAccountDialog(BuildContext context, Account account) {
    return showDialog(
      context: context, 
      builder: (context){
        final formKey = GlobalKey<FormState>();
        TextEditingController accountNameController = TextEditingController();
        return AlertDialog(
          title: const Text('Editar cuenta'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: accountNameController,
                      maxLength: 20,
                      minLines: 1,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: 'Nombre de la cuenta',
                        hintMaxLines: 2

                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty|| value.trim().isEmpty) {
                          return 'Ingrese un nombre';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              );
            }
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: const Text('Cancelar', style: TextStyle(color: CustomColors.black))
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final editedAccount = Account(
                    accountName: accountNameController.text,
                    ownerId: globalUser!.id);
                  FirebaseFirestore.instance.collection('Accounts')
                    .doc(account.accountId)
                    .update(editedAccount.toJson())
                    .then((value){
                      Navigator.pop(context);
                      successScaffoldMsg(context, 'Cuenta editada con éxito');
                      //setState(() {});
                    }).catchError((error){
                      errorScaffoldMsg(context, 'Error al editar la cuenta');
                    });
                }
              }, 
              child: const Text('Editar', style: TextStyle(color: CustomColors.darkBlue))
            ),
          ],
        );
      }
      );
  }

  Future<dynamic> createAccountDialog(BuildContext context) {
    return showDialog(
      context: context, 
      builder: (context){
        final formKey = GlobalKey<FormState>();
        TextEditingController accountNameController = TextEditingController();
        return AlertDialog(
          title: const Text('Añadir Cuenta'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: accountNameController,
                      maxLength: 20,
                      minLines: 1,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: 'Nombre de la cuenta',
                        hintMaxLines: 2,
                        
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty|| value.trim().isEmpty) {
                          return 'Ingrese un nombre';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              );
            }
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: const Text('Cancelar', style: TextStyle(color: CustomColors.black))
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final newAccount = Account(
                    accountName: accountNameController.text,
                    ownerId: globalUser!.id);
                  FirebaseFirestore.instance.collection('Accounts')
                    .add(newAccount.toJson())
                    .then((value){
                      Navigator.pop(context);
                      successScaffoldMsg(context, 'Cuenta añadida con éxito');
                      //setState(() {});
                    }).catchError((error){
                      errorScaffoldMsg(context, 'Error al añadir la cuenta');
                    });
                }
              }, 
              child: const Text('Añadir', style: TextStyle(color: CustomColors.darkBlue))
            ),
          ],
        );

      });
  }

  Future<dynamic> deleteAccountDialog(BuildContext context, Account account) {
    return showDialog(
      context: context, 
      builder:
      (context) => AlertDialog(
        title: const Text('Eliminar cuenta'),
        content: const Text('Se eliminará la cuenta y todos los registros asociados. Continuar?',
          maxLines: 3,
          overflow: TextOverflow.ellipsis,),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            }, 
            child: const Text('Cancelar', style: TextStyle(color: CustomColors.black))
          ),
          ElevatedButton(
            onPressed: () async {
              await FirebaseFirestore.instance.collection('Accounts')
              .doc(account.accountId)
              .delete()
              .then((value){
                FirebaseFirestore.instance.collection('Registries').where('accountId', isEqualTo: account.accountId).get().then((snapshot) {
                  for (DocumentSnapshot doc in snapshot.docs) {
                    doc.reference.delete();
                  }
                });
                Navigator.pop(context);
                successScaffoldMsg(context, 'Cuenta eliminada con éxito');
                //setState(() {});
              }).catchError((error){
                errorScaffoldMsg(context, 'Error al eliminar la cuenta');
              });
            }, 
            child: const Text('Eliminar', style: TextStyle(color: CustomColors.darkBlue))
          ),
        ],
      )
    );
  }
