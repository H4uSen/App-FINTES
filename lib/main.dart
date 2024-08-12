
import 'package:app_fintes/business_logic/models/user_model.dart';
import 'package:app_fintes/pages/accountdetails_page.dart';
import 'package:app_fintes/pages/acctmanagement_page.dart';
import 'package:app_fintes/pages/home_page.dart';
import 'package:app_fintes/pages/principal_page.dart';
import 'package:app_fintes/pages/login_page.dart';
import 'package:app_fintes/pages/registro_page.dart';
import 'package:app_fintes/pages/registrydetails_page.dart';
import 'package:app_fintes/widgets/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:app_fintes/business_logic/data/globals.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: customThemeData,
      debugShowCheckedModeBanner: false,
      initialRoute: '/principal',
      routes: {
        '/principal': (context) => const PrincipalPage(),
        '/login': (context) => const LoginPage(),
        '/registro': (context) => const RegistroPage(),
        '/home': (context) => const InicioPage(),
        '/registrydetails': (context) => const RegistrydetailsPage(),
        '/accountdetails': (context) => const AccountDetailsPage(),
        '/accountmanagement': (context) => const GestionCuentas(),
      },
    );
  }
}