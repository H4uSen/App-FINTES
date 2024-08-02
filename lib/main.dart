import 'package:app_fintes/pages/principal_page.dart';
import 'package:app_fintes/widgets/theme_config.dart';
import 'package:flutter/material.dart';

//import 'package:flutter/registro_page.dart';

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
      home: const PrincipalPage(),
    );
  }
}
