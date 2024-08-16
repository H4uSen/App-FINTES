import 'package:app_fintes/business_logic/data/globals.dart';
import 'package:app_fintes/business_logic/models/registry_model.dart';
import 'package:app_fintes/business_logic/registry_functions.dart';
import 'package:app_fintes/business_logic/utilitity_functions.dart';
import 'package:app_fintes/widgets/scaffoldmsgs.dart';
import 'package:app_fintes/widgets/form/custom_dropdown.dart';
import 'package:app_fintes/widgets/form/custom_textformfield.dart';
import 'package:app_fintes/widgets/theme_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewRegistryPage extends StatefulWidget {
  const NewRegistryPage({super.key});

  @override
  State<NewRegistryPage> createState() => _NewRegistryPage();
}

class _NewRegistryPage extends State<NewRegistryPage> {
  final _formKey = GlobalKey<FormState>();
  bool isEditable = true;
  TextEditingController? titleController = TextEditingController();
  TextEditingController? descriptionController = TextEditingController();
  TextEditingController? amountController = TextEditingController();
  String? selectedType, selectedAccount;
  late Future<List<Map<String, dynamic>>> accountsFuture;


    @override
    void initState() {
      super.initState();
      accountsFuture = getAccounts(globalUser!.id);
    }

  @override
  Widget build(BuildContext context) {
  List<DropdownMenuItem<String>> accountOptions = [const DropdownMenuItem<String>(value: "default", child: Text("default") )];

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
    selectedType = registryTypeOpts[0].value;


    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalles',
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            setState(() {});
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),

      body: Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: ListView(
          children: [

            CustomTextFormField(
              controller: titleController,
              labelText: "Título", 
              isEditable: isEditable,
              maxLength: 50,
              maxLines: 3,
              validator: (v)=>(v!.isEmpty)?'Este campo es requerido':null,
            ),

            CustomTextFormField(
              labelText: "Descripción", 
              controller: descriptionController,
              isEditable: isEditable,
              maxLength: 90,
              maxLines: 3,
            ),

            CustomTextFormField(
              labelText: "Cantidad", 
              controller: amountController,
              isEditable: isEditable,
              textAlignment: TextAlign.end,              
              prefixText: 'L. ',
              keyboardType: TextInputType.number,
              maxLength: 16,
              validator: (val){
                if(val!.trim().isEmpty) return 'Este campo es requerido';
                if(double.tryParse(val) == null) return 'Ingrese un número válido';
                if(double.parse(val) <= 0) return 'Ingrese un número mayor a 0';
                return null;
              },
            ),

            FutureBuilder(
              future: accountsFuture,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                final response = snapshotValidation(snapshot);
                if(response != null) return response;

                final accounts = snapshot.data;

                accountOptions = [
                  for (var account in accounts)
                    DropdownMenuItem<String>(
                      value: account["accountId"] + "-" + account["accountType"],
                      child: Text(account["accountName"].toString()),
                    ) 
                ];
                selectedAccount = accountOptions[0].value;
                return CustomDropDown(
                  isEditable: isEditable,
                  labeltext: 'Cuenta:',
                  value: accountOptions[0].value,
                  options: accountOptions,
                  onChanged: (val){
                    selectedAccount = val!;
                  },
                );
              },
            ),

            CustomDropDown(
              isEditable: isEditable,
              labeltext: 'Tipo:',
              value: selectedType,
              options: registryTypeOpts,
              onChanged: (val){
                selectedType = val!;
              },
            ),

            const SizedBox(height: 6),
            const Text(
              'Fecha de creación:',
              style: TextStyle(fontWeight: FontWeight.bold,color: CustomColors.black),
            ),
            Text(
              formattedDate(DateTime.now()),
              style: Theme.of(context).textTheme.bodyMedium!.apply(color: CustomColors.black),
            ),
            const SizedBox(height: 50),

            Visibility(
              visible: isEditable,
              child: Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save, color: CustomColors.white,size: 30,),
                  label: Text('Guardar', style: Theme.of(context).textTheme.bodyLarge!.apply(color: CustomColors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.black,
                    fixedSize: Size(MediaQuery.of(context).size.width * 0.8, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      
                      Registry newRegistry = Registry(
                        title: titleController!.text,
                        description: descriptionController!.text,
                        amount: double.parse(amountController!.text),
                        accountId: selectedAccount!.split("-")[0],
                        accountType: selectedAccount!.split("-")[1],
                        ownerId: globalUser!.id,
                        isDeposit: (selectedType == 'Ingreso'),
                        date: formattedDate(DateTime.now()),
                      );
                      
                      await createRegistry(newRegistry).then((val){
                        if(val){
                          successScaffoldMsg(context, "Registro guardado exitosamente");
                          Navigator.pushReplacementNamed(context, "/home");
                        } else {
                          errorScaffoldMsg(context, "No se pudo guardar el registro");
                        }
                      });
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        
      ),
    )
    );
  }
}




  Future<List<Map<String, dynamic>>> getAccounts (String userId) async {
  List<Map<String,dynamic>> accounts =[];
  final accountsRef = FirebaseFirestore.instance.collection("Accounts");
  final goalsRef = FirebaseFirestore.instance.collection("Goals");
  final recurrentsRef = FirebaseFirestore.instance.collection("Recurrents");
  await accountsRef.where("ownerId",isEqualTo: userId).get().then((value) {
    accounts.clear();
    for (var doc in value.docs){
      Map<String,String> account = {
        'accountId': doc.id,
        'accountName': doc['name'],
        'accountType': AccountType.account,
      };
      accounts.add(account);
    }
  }).then((value) async{
    await goalsRef.where("ownerId",isEqualTo: userId).get().then((value) {
      for (var doc in value.docs){
        Map<String,String> account = {
          'accountId': doc.id,
          'accountName': doc['name'],
          'accountType': AccountType.goal
        };
        accounts.add(account);
      }
    });
  }).then((value) async{
    await recurrentsRef.where("ownerId",isEqualTo: userId).get().then((value) {
      for (var doc in value.docs){
        Map<String,String> account = {
          'accountId': doc.id,
          'accountName': doc['name'],
          'accountType': AccountType.recurrentPayment
        };
        accounts.add(account);
      }
    });
  }).catchError((error){});
  return accounts;
  }
