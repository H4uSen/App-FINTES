
import 'package:app_fintes/pages/accountdetails_page.dart';
import 'package:app_fintes/pages/acctmanagement_page.dart';
import 'package:app_fintes/pages/home_page.dart';
import 'package:app_fintes/pages/newregistry_page.dart';
import 'package:app_fintes/pages/principal_page.dart';
import 'package:app_fintes/pages/login_page.dart';
import 'package:app_fintes/pages/registro_page.dart';
import 'package:app_fintes/pages/registrydetails_page.dart';
import 'package:app_fintes/widgets/theme_config.dart';
import 'package:flutter/material.dart';

// Import the generated file
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        '/newregistry': (context) => const NewRegistryPage(),
      },
      onGenerateRoute: (settings) => MaterialPageRoute(
        builder: (context) => const PrincipalPage(),
      ),
    );
  }
}