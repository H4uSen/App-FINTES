
import 'package:app_fintes/business_logic/data/globals.dart';
import 'package:app_fintes/business_logic/models/recurrent_model.dart';
import 'package:app_fintes/widgets/form/custom_dropdown.dart';
import 'package:app_fintes/widgets/form/custom_textformfield.dart';
import 'package:app_fintes/widgets/scaffoldmsgs.dart';
import 'package:app_fintes/widgets/theme_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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


Future<List<RecurrentPayment>> getRecurrents(String userId) async {
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


  Future<dynamic> updateRecurrentDialog(BuildContext context, RecurrentPayment account) {
    return showDialog(
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
      TextEditingController recurrentDayController = TextEditingController(text: account.recurrentDay.toString());
      String? selectedType = account.isDeposit ? 'Ingreso' : 'Egreso';
      return AlertDialog(
        title: const Text('Editar cuenta'),
        content: StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Form(
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
                      CustomTextFormField(
                          labelText: 'Dia de pago', 
                          isEditable: true, 
                          controller: recurrentDayController,
                          keyboardType: TextInputType.number,
                          textAlignment: TextAlign.end,
                          maxLength: 2,
                          maxLines: 1,
                          validator: (value) {
                            if (value == null || value.isEmpty|| value.trim().isEmpty) {
                              return 'Ingrese una cantidad';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Ingrese un número válido';
                            }
                            if (double.parse(value) <= 1) {
                              return 'Ingrese un número mayor a 1';
                            }
                            if (double.parse(value) > 31) {
                              return 'Ingrese un número menor a 30';
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
            child: Text('Cancelar', style: Theme.of(context).textTheme.bodyMedium)
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final editedAccount = RecurrentPayment(
                  recurrentAmount: double.parse(recurrentAmountController.text),
                  isDeposit: selectedType == 'Ingreso',
                  recurrentName: recurrentNameController.text,
                  recurrentDay: int.parse(recurrentDayController.text),
                  ownerId: globalUser!.id);
                FirebaseFirestore.instance.collection('Recurrents')
                  .doc(account.recurrentId)
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
            child: Text('Editar', style: Theme.of(context).textTheme.bodyMedium!.apply(color: CustomColors.darkBlue))
          ),
        ],
      );
    }
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
          child: Text('Cancelar', style: Theme.of(context).textTheme.bodyMedium)
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
              //setState(() {});
            }).catchError((error){
              errorScaffoldMsg(context, 'Error al eliminar el pago');
            });
          }, 
          child: Text('Eliminar', style: Theme.of(context).textTheme.bodyMedium!.apply(color: CustomColors.darkBlue))
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
      TextEditingController recurrentDayController = TextEditingController();
      return AlertDialog(
        title: const Text('Añadir pago recurrente'),
        content: StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Form(
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
                        CustomTextFormField(
                          labelText: 'Dia de pago', 
                          isEditable: true, 
                          controller: recurrentDayController,
                          keyboardType: TextInputType.number,
                          textAlignment: TextAlign.end,
                          maxLength: 2,
                          maxLines: 1,
                          validator: (value) {
                            if (value == null || value.isEmpty|| value.trim().isEmpty) {
                              return 'Ingrese una cantidad';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Ingrese un número válido';
                            }
                            if (double.parse(value) <= 1) {
                              return 'Ingrese un número mayor a 1';
                            }
                            if (double.parse(value) > 31) {
                              return 'Ingrese un número menor a 30';
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
            child: Text('Cancelar', style:Theme.of(context).textTheme.bodyMedium)
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final newRecurrent = RecurrentPayment(
                  isDeposit: selectedType == 'Ingreso',
                  recurrentAmount: double.parse(recurrentAmountController.text),                    
                  recurrentName: recurrentNameController.text,
                  recurrentDay: int.parse(recurrentDayController.text),
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
            child: Text('Añadir', style: Theme.of(context).textTheme.bodyMedium!.apply(color: CustomColors.darkBlue))
          ),
        ],
      );

    });
  }
