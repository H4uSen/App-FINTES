import 'package:app_fintes/business_logic/transaction_details.dart';
import 'package:flutter/material.dart';

class RegistrydetailsPage extends StatefulWidget {
  const RegistrydetailsPage({super.key});

  @override
  State<RegistrydetailsPage> createState() => _RegistrydetailsPageState();
}

class _RegistrydetailsPageState extends State<RegistrydetailsPage> {
  @override
  Widget build(BuildContext context) {
    final RegistryDetails registryDetails = ModalRoute.of(context)!.settings.arguments as RegistryDetails;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalles',
        ),
        centerTitle: true,
      ),

    );
  }
}