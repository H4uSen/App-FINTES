// pages/acctmanagement_page.dart
import 'package:app_fintes/business_logic/account_functions.dart';
import 'package:app_fintes/business_logic/data/globals.dart';
import 'package:app_fintes/business_logic/goal_functions.dart';
import 'package:app_fintes/business_logic/models/account_model.dart';
import 'package:app_fintes/business_logic/models/goal_model.dart';
import 'package:app_fintes/business_logic/models/recurrent_model.dart';
import 'package:app_fintes/business_logic/recurrent_functions.dart';
import 'package:app_fintes/business_logic/utilitity_functions.dart';
import 'package:app_fintes/pages/drawer.dart';
import 'package:app_fintes/widgets/acct_listtile.dart';
import 'package:app_fintes/widgets/form/custom_button.dart';
import 'package:app_fintes/widgets/form/custom_dropdown.dart';
import 'package:app_fintes/widgets/form/custom_textformfield.dart';
import 'package:app_fintes/widgets/scaffoldmsgs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:app_fintes/widgets/theme_config.dart'; 
import 'package:app_fintes/widgets/drawer/divider.dart';

class GestionCuentas extends StatefulWidget {
  const GestionCuentas({super.key});

  @override
  State<GestionCuentas> createState() => _GestionCuentasState();
}

class _GestionCuentasState extends State<GestionCuentas> {

  @override
  Widget build(BuildContext context) {
    final accountRef = FirebaseFirestore.instance.collection('Accounts').where('ownerId', isEqualTo: globalUser!.id);
    final goalRef = FirebaseFirestore.instance.collection('Goals').where('ownerId', isEqualTo: globalUser!.id);
    final recurrentRef = FirebaseFirestore.instance.collection('Recurrents').where('ownerId', isEqualTo: globalUser!.id);
    List<Account> accounts = [];
    List<Goal> goals = [];
    List<RecurrentPayment> recurrents = [];
    bool hasRecurrents = recurrents.isNotEmpty;
    bool hasGoals = recurrents.isNotEmpty;
    bool hasAccounts = accounts.isNotEmpty;

    //TODO: Hay que hacer que funcionen los botones de editar, eliminar y añadir
    return Scaffold(
      appBar:  AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/home");
              
            }, 
            icon: const Icon(Icons.arrow_back)
          ),

        title: const Text('Ajustes de la cuenta'),
        backgroundColor: CustomColors.lightBlue,
      ),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomDivider(
                title: 'Cuentas',
                showLines: true,
              ),
              const SizedBox(height: 15),
                FutureBuilder(
                  future: accountRef.get(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
          
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
          
                    final querySnapshot = snapshot.data;
          
                    if (querySnapshot == null) {
                      return const Text('No hay documentos');
                    }
                    accounts = querySnapshot.docs.map((doc) => Account.fromJson(doc.data(), doc.id)).toList();
                    
                    List<Widget> accountTiles = [];
                    for (var account in accounts){
                      accountTiles.add(
                        AcctListtile(
                          title: account.accountName,
                          leadingIcon: Icons.attach_money,
                          editIcon: Icons.edit,
                          deleteIcon: Icons.delete,
                          onEdit: () {
                            updateAccountDialog(context, account).whenComplete(() {
                              setState(() {
                              });
                            });
                          },
                          onDelete: () {
                            deleteAccountDialog(context, account).whenComplete(() {
                              setState(() {
                              });
                            });
                            
                          },
                        )
                      );
                    }
                    return Column(
                      children: accountTiles,
                    );  
                  }
                ),
              Visibility(
                visible: hasAccounts,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: CustomDivider(title: 'Vacío', showLines: false),
                ),
              ),
              const SizedBox(height: 10),
              CustomOutlinedButton(
                label: 'Añadir cuenta',
                backgroundColor: CustomColors.darkBlue,
                onPressed: () {
                  createAccountDialog(context).whenComplete(() {
                    setState(() {
                    });
                  });
                  
                },
              ),
              
          
          
          
              const CustomDivider(
                title: 'Metas',
                showLines: true,
              ),
              const SizedBox(height: 15),
              FutureBuilder(
                future: goalRef.get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
          
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
          
                    final querySnapshot = snapshot.data;
          
                    if (querySnapshot == null) {
                      return const Text('No hay documentos');
                    }
                  goals = querySnapshot.docs.map((doc) => Goal.fromJson(doc.data(), doc.id)).toList();
                  List<Widget> accountTiles = [];
                  for (var account in goals){
                    accountTiles.add(
                      AcctListtile(
                        title: account.goalName,
                        leadingIcon: Icons.flag,
                        editIcon: Icons.edit,
                        deleteIcon: Icons.delete,
                        leadingIconBackgroundColor: CustomColors.yellow,
                        onEdit: () {
                          updateGoalDialog(context, account).whenComplete(() {
                            setState(() {
                            });
                          });
                        },
                        onDelete: () {
                          deleteGoalDialog(context, account).whenComplete(() {
                            setState(() {
                            });
                          });
                        },
                      )
                    );
                  }
          
                  return Column(
                    children: accountTiles,
                  );  
                }
              ),
              Visibility(
                  visible: hasGoals,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: CustomDivider(title: 'Vacío', showLines: false),
                  ),
                ),
          
              const SizedBox(height: 10),
              CustomOutlinedButton(
                label: 'Añadir meta',
                backgroundColor: CustomColors.darkBlue,
                
                onPressed: () {
                  createGoalDialog(context)
                  .whenComplete((){
                    setState(() {
                    });
                  });
                },
              ),
          
          
          
          
              const CustomDivider(
                title: 'Pagos recurrentes',
                showLines: true,
              ),
              const SizedBox(height: 15),
              FutureBuilder(
                future: recurrentRef.get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
          
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
          
                    final querySnapshot = snapshot.data;
          
                    if (querySnapshot == null) {
                      return const Text('No hay documentos');
                    }
                  recurrents = querySnapshot.docs.map((doc) => RecurrentPayment.fromJson(doc.data(), doc.id)).toList();
                  List<Widget> accountTiles = [];
                  for (var account in recurrents){
                    accountTiles.add(
                      AcctListtile(
                        title: account.recurrentName,
                        leadingIcon: Icons.flag,
                        editIcon: Icons.edit,
                        deleteIcon: Icons.delete,
                        leadingIconBackgroundColor: CustomColors.red,
                        onEdit: () {
                          showDialog(
      context: context, 
      builder: (context){
        final formKey = GlobalKey<FormState>();
        List<DropdownMenuItem<String>> registryTypeOpts = const [
        DropdownMenuItem<String>(
          value: 'Ingreso',
          child: Text('Ingreso'),
        ),
        DropdownMenuItem<String>(
          value: 'Egreso',
          child: Text('Egreso'),
        ),
      ];
        TextEditingController recurrentNameController = TextEditingController(text: account.recurrentName);
        TextEditingController recurrentAmountController = TextEditingController(text: account.recurrentAmount.toString());
        String? selectedType = account.isDeposit ? 'Ingreso' : 'Egreso';
        return AlertDialog(
          title: const Text('Editar cuenta'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  CustomTextFormField(
                    controller: recurrentNameController,
                    isEditable: true,
                    maxLength: 20,
                    minLines: 1,
                    maxLines: 2,
                    labelText: 'Nombre del pago',
                    validator: (value) {
                      if (value == null || value.isEmpty|| value.trim().isEmpty) {
                        return 'Ingrese un nombre';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    labelText: 'Cantidad', 
                    isEditable: true, 
                    controller: recurrentAmountController,
                    keyboardType: TextInputType.number,
                    prefixText:'L.',
                    textAlignment: TextAlign.end,
                    maxLength: 20,
                    maxLines: 1,
                    validator: (value) {
                      if (value == null || value.isEmpty|| value.trim().isEmpty) {
                        return 'Ingrese una cantidad';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Ingrese un número válido';
                      }
                      if (double.parse(value) <= 0) {
                        return 'Ingrese un número mayor a 0';
                      }
                      return null;
                    },
                  ),
                  CustomDropDown(
                    isEditable: true,
                    labeltext: 'Tipo:',
                    value: selectedType,
                    options: registryTypeOpts,
                    onChanged: (val){
                      selectedType = val!;
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
                  final editedAccount = RecurrentPayment(
                    recurrentAmount: double.parse(recurrentAmountController.text),
                    isDeposit: selectedType == 'Ingreso',
                    recurrentName: recurrentNameController.text,
                    ownerId: globalUser!.id);
                  FirebaseFirestore.instance.collection('Recurrents')
                    .doc(account.recurrentId)
                    .update(editedAccount.toJson())
                    .then((value){
                      Navigator.pop(context);
                      successScaffoldMsg(context, 'Cuenta editada con éxito');
                      setState(() {});
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
                        },
                        onDelete: () {
                          deleteRecurrentDialog(context, account);
                        },
                      )
                    );
                  }
          
                  return Column(
                    children: accountTiles,
                  );  
                }
              ),
                Visibility(
                    visible: hasRecurrents,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: CustomDivider(title: 'Vacío', showLines: false),
                    ),
                  ),   
              const SizedBox(height: 10),
              CustomOutlinedButton(
                label: 'Añadir pago recurrente',
                backgroundColor: CustomColors.darkBlue,
                onPressed: () {
                  createRecurrentDialog(context).whenComplete(() {
                    setState(() {
                    });
                  });
                },
              ),
              const SizedBox(height: 15),
              ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> deleteRecurrentDialog(BuildContext context, RecurrentPayment account) {
    return showDialog(
    context: context, 
    builder:
    (context) => AlertDialog(
      title: const Text('Eliminar pago recurrente'),
      content: const Text('Se eliminará el pago y todos los registros asociados. Continuar?',
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
            await FirebaseFirestore.instance.collection('Recurrents')
            .doc(account.recurrentId)
            .delete()
            .then((value){
              FirebaseFirestore.instance.collection('Registries').where('accountId', isEqualTo: account.recurrentId).get().then((snapshot) {
                for (DocumentSnapshot doc in snapshot.docs) {
                  doc.reference.delete();
                }
              });
              Navigator.pop(context);
              successScaffoldMsg(context, 'Pago eliminado con éxito');
              setState(() {});
            }).catchError((error){
              errorScaffoldMsg(context, 'Error al eliminar el pago');
            });
          }, 
          child: const Text('Eliminar', style: TextStyle(color: CustomColors.darkBlue))
        ),
      ],
    )
  );
  }

  Future<dynamic> createRecurrentDialog(BuildContext context) {
    return showDialog(
    context: context, 
    builder: (context){
      String? selectedType = "Ingreso";
      List<DropdownMenuItem<String>> registryTypeOpts = const [
        DropdownMenuItem<String>(
          value: 'Ingreso',
          child: Text('Ingreso'),
        ),
        DropdownMenuItem<String>(
          value: 'Egreso',
          child: Text('Egreso'),
        ),
      ];
      final formKey = GlobalKey<FormState>();
      TextEditingController recurrentNameController = TextEditingController();
      TextEditingController recurrentAmountController = TextEditingController();
      return AlertDialog(
        title: const Text('Añadir pago recurrente'),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextFormField(
                    controller: recurrentNameController,
                    isEditable: true,
                    maxLength: 20,
                    minLines: 1,
                    maxLines: 2,
                    labelText: 'Nombre del pago',
                    validator: (value) {
                      if (value == null || value.isEmpty|| value.trim().isEmpty) {
                        return 'Ingrese un nombre';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    labelText: 'Cantidad', 
                    isEditable: true, 
                    controller: recurrentAmountController,
                    keyboardType: TextInputType.number,
                    prefixText:'L.',
                    textAlignment: TextAlign.end,
                    maxLength: 20,
                    maxLines: 1,
                    validator: (value) {
                      if (value == null || value.isEmpty|| value.trim().isEmpty) {
                        return 'Ingrese una cantidad';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Ingrese un número válido';
                      }
                      if (double.parse(value) <= 0) {
                        return 'Ingrese un número mayor a 0';
                      }
                      return null;
                    },
                  ),
                  CustomDropDown(
                    isEditable: true,
                    labeltext: 'Tipo:',
                    value: selectedType,
                    options: registryTypeOpts,
                    onChanged: (val){
                      selectedType = val!;
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
                final newRecurrent = RecurrentPayment(
                  isDeposit: selectedType == 'Ingreso',
                  recurrentAmount: double.parse(recurrentAmountController.text),                    recurrentName: recurrentNameController.text,
                  ownerId: globalUser!.id);
                FirebaseFirestore.instance.collection('Recurrents')
                  .add(newRecurrent.toJson())
                  .then((value){
                    Navigator.pop(context);
                    successScaffoldMsg(context, 'Pago añadido con éxito');
                    //setState(() {});
                  }).catchError((error){
                    errorScaffoldMsg(context, 'Error al añadir el pago');
                  });
              }
            }, 
            child: const Text('Añadir', style: TextStyle(color: CustomColors.darkBlue))
          ),
        ],
      );

    });
  }


}