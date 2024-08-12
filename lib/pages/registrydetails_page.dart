import 'package:app_fintes/business_logic/data/globals.dart';
import 'package:app_fintes/business_logic/data_functions.dart';
import 'package:app_fintes/business_logic/models/account_model.dart';
import 'package:app_fintes/business_logic/models/registry_model.dart';
import 'package:app_fintes/widgets/form/custom_dopdown.dart';
import 'package:app_fintes/widgets/form/custom_textformfield.dart';
import 'package:app_fintes/widgets/theme_config.dart';
import 'package:flutter/material.dart';

class RegistrydetailsPage extends StatefulWidget {
  const RegistrydetailsPage({super.key});

  @override
  State<RegistrydetailsPage> createState() => _RegistrydetailsPageState();
}

class _RegistrydetailsPageState extends State<RegistrydetailsPage> {
  bool isEditable = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Registry registry = ModalRoute.of(context)!.settings.arguments as Registry;
    List<Account> accounts = getUserAccounts(globalUser!.id);
    List<DropdownMenuItem<String>> options = [
      for (Account account in accounts)
        DropdownMenuItem<String>(
          value: account.accountId,
          child: Text(account.accountName),
        )
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalles',
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          TextButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>((isEditable)?CustomColors.darkBlue: CustomColors.lightBlue),
            ),
            onPressed: (){
              isEditable = !isEditable;
              setState(() {});
            }, 
            child: Row(
              children: [
                Icon(
                  Icons.edit, 
                  color: ((isEditable)?CustomColors.black: CustomColors.white),
                  size: 30,
                ),
                Text(
                  (!isEditable)?'Editar':'Cancelar', 
                  style: TextStyle(color: ((isEditable)?CustomColors.black: CustomColors.white), 
                  fontSize: 20),),
              ],
            ),
          ),
        ],
      ),

      body: Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: ListView(
          children: [

            CustomTextFormField(
              initialValue: registry.title, 
              labelText: "Título", 
              isEditable: isEditable,
              maxLength: 50,
              maxLines: 3,
              validator: (v)=>(v!.isEmpty)?'Este campo es requerido':null,
            ),

            CustomTextFormField(
              initialValue: "",
              labelText: "Descripción", 
              isEditable: isEditable,
              maxLength: 90,
              maxLines: 3,
            ),

            CustomTextFormField(
              initialValue: registry.amount.toString(),
              labelText: "Cantidad", 
              isEditable: isEditable,
              textAlignment: TextAlign.end,              
              prefixText: 'L. ',
              keyboardType: TextInputType.number,
              maxLength: 16,
            ),

            CustomDropDown(
              isEditable: isEditable,
              labeltext: 'Cuenta',
              options: options,
              onChanged: (String? newValue) {
                registry.accountId = newValue!;
              },
              ),


            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cuenta:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      DropdownButton<String>(
                        isExpanded: true,
                        value: 'Efectivo',
                        items: <String>['Efectivo', 'Tarjeta', 'Banco']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          // Add your onChanged logic here
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tipo:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      DropdownButton<String>(
                        isExpanded: true,
                        value: 'Ingreso',
                        items: <String>['Ingreso', 'Egreso']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          registry.accountId = newValue!;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Fecha de registro:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '28/7/2024',
              style: TextStyle(fontSize: 16),
            ),
            
            
            
            Visibility(
              visible: !isEditable,
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Add your delete functionality here
                  },
                  icon: Icon(Icons.delete, color: CustomColors.white,size: 30,),
                  label: Text('Eliminar', style: Theme.of(context).textTheme.bodyLarge!.apply(color: CustomColors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.black,
                    fixedSize: Size(MediaQuery.of(context).size.width * 0.8, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),

            Visibility(
              visible: isEditable,
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Add your save functionality here
                    }
                  },
                  icon: Icon(Icons.save, color: CustomColors.white,size: 30,),
                  label: Text('Guardar', style: Theme.of(context).textTheme.bodyLarge!.apply(color: CustomColors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.black,
                    fixedSize: Size(MediaQuery.of(context).size.width * 0.8, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
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
