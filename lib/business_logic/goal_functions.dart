
import 'package:app_fintes/business_logic/data/globals.dart';
import 'package:app_fintes/business_logic/models/goal_model.dart';
import 'package:app_fintes/business_logic/models/registry_model.dart';
import 'package:app_fintes/business_logic/registry_functions.dart';
import 'package:app_fintes/widgets/form/custom_textformfield.dart';
import 'package:app_fintes/widgets/scaffoldmsgs.dart';
import 'package:app_fintes/widgets/theme_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

Future<List<Goal>> getGoals(String userId)  async {
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

  Future<dynamic> createGoalDialog(BuildContext context) {
    return showDialog(
                context: context, 
                builder: (context){
                  final formKey = GlobalKey<FormState>();
                  TextEditingController goalNameController = TextEditingController();
                  TextEditingController amountController = TextEditingController();
                  return AlertDialog(
                    title: const Text('Añadir meta'),
                    content: StatefulBuilder(
                      builder: (context, setState) {
                        return SingleChildScrollView(
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomTextFormField(
                                  controller: goalNameController,
                                  isEditable: true,
                                  maxLength: 20,
                                  minLines: 1,
                                  maxLines: 2,
                                  labelText: 'Nombre',
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
                                  controller: amountController,
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
                              ],
                            ),
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
                            final newGoal = Goal(
                              goalName: goalNameController.text,
                              goalAmount: double.parse(amountController.text),
                              ownerId: globalUser!.id);
                            FirebaseFirestore.instance.collection('Goals')
                              .add(newGoal.toJson())
                              .then((value){
                                Navigator.pop(context);
                                successScaffoldMsg(context, 'Meta añadida con éxito');
                                //setState(() {});
                              }).catchError((error){
                                errorScaffoldMsg(context, 'Error al añadir la meta');
                              });
                          }
                        }, 
                        child: Text('Añadir', style: Theme.of(context).textTheme.bodyMedium!.apply(color: CustomColors.darkBlue))
                      ),
                    ],
                  );

                });
  }

  Future<dynamic> deleteGoalDialog(BuildContext context, Goal account) {
    return showDialog(
    context: context, 
    builder:
    (context) => AlertDialog(
      title: const Text('Eliminar meta'),
      content: const Text('Se eliminará la meta y todos los registros asociados. Continuar?',
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
            await FirebaseFirestore.instance.collection('Goals')
            .doc(account.goalId)
            .delete()
            .then((value){
              FirebaseFirestore.instance.collection('Registries').where('accountId', isEqualTo: account.goalId).get().then((snapshot) {
                for (DocumentSnapshot doc in snapshot.docs) {
                  doc.reference.delete();
                }
              });
              Navigator.pop(context);
              successScaffoldMsg(context, 'Meta eliminada con éxito');
              //setState(() {});
            }).catchError((error){
              errorScaffoldMsg(context, 'Error al eliminar la meta');
            });
          }, 
          child: Text('Eliminar', style: Theme.of(context).textTheme.bodyMedium!.apply(color: CustomColors.darkBlue))
        ),
      ],
    )
  );
  }

  Future<dynamic> updateGoalDialog(BuildContext context, Goal account) {
    return showDialog(
    context: context, 
    builder: (context){
      final formKey = GlobalKey<FormState>();
      TextEditingController goalNameController = TextEditingController(text: account.goalName);
      TextEditingController amountController = TextEditingController(text: account.goalAmount.toString());
      return AlertDialog(
        title: const Text('Editar meta'),
        content: StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextFormField(
                                  controller: goalNameController,
                                  isEditable: true,
                                  maxLength: 20,
                                  minLines: 1,
                                  maxLines: 2,
                                  labelText: 'Nombre',
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
                                  controller: amountController,
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
                  ],
                ),
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
                final editedAccount = Goal(
                  goalName: goalNameController.text,
                  goalAmount: double.parse(amountController.text),
                  ownerId: globalUser!.id);
                FirebaseFirestore.instance.collection('Goals')
                  .doc(account.goalId)
                  .update(editedAccount.toJson())
                  .then((value){
                    Navigator.pop(context);
                    successScaffoldMsg(context, 'Meta editada con éxito');
                    //setState(() {});
                  }).catchError((error){
                    errorScaffoldMsg(context, 'Error al editar la meta');
                  });
              }
            }, 
            child: Text('Guardar', style: Theme.of(context).textTheme.bodyMedium!.apply(color: CustomColors.darkBlue))
          ),
        ],
      );
    }
    );
  }

