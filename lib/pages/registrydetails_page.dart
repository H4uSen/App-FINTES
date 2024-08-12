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
    List<DropdownMenuItem<String>> accountOptions = [
      for (Account account in accounts)
        DropdownMenuItem<String>(
          value: account.accountId,
          child: Text(account.accountName),
        )
    ];
    List<DropdownMenuItem<String>> resgistryTypeOpts = const [
      DropdownMenuItem<String>(
        value: 'Ingreso',
        child: Text('Ingreso'),
      ),
      DropdownMenuItem<String>(
        value: 'Egreso',
        child: Text('Egreso'),
      ),
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
              
              if(!isEditable) Navigator.popAndPushNamed(context, '/registrydetails', arguments: registry);
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
              validator: (val){
                if(val!.isEmpty) return 'Este campo es requerido';
                if(double.tryParse(val) == null) return 'Ingrese un número válido';
                if(double.parse(val) <= 0) return 'Ingrese un número mayor a 0';
                return null;
              },
            ),

            CustomDropDown(
              isEditable: isEditable,
              labeltext: 'Cuenta:',
              value: registry.accountId,
              options: accountOptions,
              onChanged: (String? newValue) {
                },
              ),

            CustomDropDown(
              isEditable: isEditable,
              labeltext: 'Tipo:',
              value: (registry.isDeposit)?'Ingreso':'Egreso',
              options: resgistryTypeOpts,
              onChanged: (String? newValue) {
                print(newValue);
              },
            ),

            const SizedBox(height: 6),
            const Text(
              'Fecha de creación:',
              style: TextStyle(fontWeight: FontWeight.bold,color: CustomColors.black),
            ),
            Text(
              registry.date,
              style: Theme.of(context).textTheme.bodyMedium!.apply(color: CustomColors.black),
            ),
            const SizedBox(height: 50),

            
            
            Visibility(
              visible: !isEditable,
              child: Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.delete, color: CustomColors.white,size: 30,),
                  label: Text('Eliminar', style: Theme.of(context).textTheme.bodyLarge!.apply(color: CustomColors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.black,
                    fixedSize: Size(MediaQuery.of(context).size.width * 0.8, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // Add your delete functionality here
                  },
                ),
              ),
            ),

            Visibility(
              visible: isEditable,
              child: Center(
                child: ElevatedButton.icon(
                  icon: Icon(Icons.save, color: CustomColors.white,size: 30,),
                  label: Text('Guardar', style: Theme.of(context).textTheme.bodyLarge!.apply(color: CustomColors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.black,
                    fixedSize: Size(MediaQuery.of(context).size.width * 0.8, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Add your save functionality here
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
