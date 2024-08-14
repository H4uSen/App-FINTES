import 'package:app_fintes/business_logic/account_functions.dart';
import 'package:app_fintes/business_logic/data/globals.dart';
import 'package:app_fintes/business_logic/goal_functions.dart';
import 'package:app_fintes/business_logic/models/account_model.dart';
import 'package:app_fintes/business_logic/models/goal_model.dart';
import 'package:app_fintes/business_logic/models/recurrent_model.dart';
import 'package:app_fintes/business_logic/models/registry_model.dart';
import 'package:app_fintes/business_logic/recurrent_functions.dart';
import 'package:app_fintes/business_logic/registry_functions.dart';
import 'package:app_fintes/widgets/scaffoldmsgs.dart';
import 'package:app_fintes/widgets/form/custom_dropdown.dart';
import 'package:app_fintes/widgets/form/custom_textformfield.dart';
import 'package:app_fintes/widgets/theme_config.dart';
import 'package:flutter/material.dart';

class RegistrydetailsPage extends StatefulWidget {
  const RegistrydetailsPage({super.key});

  @override
  State<RegistrydetailsPage> createState() => _RegistrydetailsPageState();
}

class _RegistrydetailsPageState extends State<RegistrydetailsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Registry registry = ModalRoute.of(context)!.settings.arguments as Registry;
      titleController!.text = registry.title;
      descriptionController!.text = registry.description;
      amountController!.text = registry.amount.toString();
      selectedType = (registry.isDeposit)?'Ingreso':'Egreso';
      selectedAccount = registry.accountId;
    });
  }

  final _formKey = GlobalKey<FormState>();
  bool isEditable = false;
  TextEditingController? titleController = TextEditingController();
  TextEditingController? descriptionController = TextEditingController();
  TextEditingController? amountController = TextEditingController();
  String? selectedType, selectedAccount;

  @override
  Widget build(BuildContext context) {
    Registry registry = ModalRoute.of(context)!.settings.arguments as Registry;
    List<Account> accounts = getUserAccounts(globalUser!.id);
    List<Goal> goals = getUserGoals(globalUser!.id);
    List<RecurrentPayment> recurrents = getUserRecurrents(globalUser!.id);
    
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
            setState(() {});
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
              onChanged: (val){
                selectedAccount = val!;
              },
            ),

            CustomDropDown(
              isEditable: isEditable,
              labeltext: 'Tipo:',
              value: (registry.isDeposit)?'Ingreso':'Egreso',
              options: resgistryTypeOpts,
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
                  onPressed: () async{
                    await deleteRegistry(registry.registryId).then((val){
                      if(val){
                        successScaffoldMsg(context, "Registro eliminado exitosamente");
                        Navigator.pop(context);
                      } else {
                        errorScaffoldMsg(context, "No se pudo eliminar el registro");
                      }
                    });
                  },
                ),
              ),
            ),

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
                        registryId: registry.registryId,
                        title: titleController!.text,
                        description: descriptionController!.text,
                        amount: double.parse(amountController!.text),
                        accountId: selectedAccount!,
                        ownerId: globalUser!.id,
                        isDeposit: (selectedType == 'Ingreso'),
                        date: registry.date,
                      );
                      
                      await updateRegistry(newRegistry).then((val){
                        if(val){
                          successScaffoldMsg(context, "Registro guardado exitosamente");
                          Navigator.pop(context);
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
