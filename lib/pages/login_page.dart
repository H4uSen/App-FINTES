// pages/login_page.dart
import 'package:app_fintes/business_logic/data/globals.dart';
import 'package:app_fintes/business_logic/models/user_model.dart';
import 'package:app_fintes/business_logic/user_functions.dart';
import 'package:app_fintes/widgets/custom.dart';
import 'package:app_fintes/widgets/theme_config.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final correoController = TextEditingController();
  final contraseniaController = TextEditingController();

  bool _obscureContrasenia = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Iniciar Sesion',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: CustomColors.lightBlue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Form(
                key: formkey,
                child: Column(
                  children: [
                    CustomForm(
                      controller: correoController,
                      label: 'Correo',
                      hintText: 'Ingrese su correo',
                      icon: const Icon(Icons.email),
                      validator: (valor) {
                        if (valor == null || valor.isEmpty) return 'Ingrese su correo';
                        if ("@".allMatches(valor,0).length > 1) return 'Ingrese un correo válido';
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    CustomForm(
                      controller: contraseniaController,
                      label: 'Contraseña',
                      hintText: 'Ingrese su contraseña',
                      icon: const Icon(Icons.password),
                      obscureText: _obscureContrasenia,
                      icon1: IconButton(
                        icon: Icon(
                          _obscureContrasenia ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureContrasenia = !_obscureContrasenia;
                          });
                        },
                      ),
                      validator: (valor){
                        if (valor == null || valor.isEmpty) return 'Ingrese su contraseña';
                        
                        return null;

                      },
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: () {
                        if (!formkey.currentState!.validate()) return;
                        User? user = login(correoController.text, contraseniaController.text);
                        if (user == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Icon(Icons.error,size: 40,),
                                  ),
                                  Text('Correo o contraseña incorrecta',overflow: TextOverflow.ellipsis,maxLines: 2,),
                                ],
                              ),
                              backgroundColor: CustomColors.red,
                            ),
                          );
                          return;
                        }
                        //globalUser = user;
                        if(globalUser == null) return;
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                        backgroundColor: CustomColors.lightBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Continuar'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 22,
                          color: CustomColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}