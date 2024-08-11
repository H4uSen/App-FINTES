// pages/login_page.dart
import 'package:app_fintes/widgets/custom.dart';
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
        backgroundColor: const Color.fromRGBO(131, 180, 255, 1),
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
                      /*  if (valor == null || valor.isEmpty) {
                          return 'El correo es obligatorio';
                        }
                      */  return null;
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
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: () {
                        if (!formkey.currentState!.validate()) return;
                        
                      Navigator.pushNamed(context, '/home');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                        backgroundColor: const Color.fromRGBO(131, 180, 255, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Continuar'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.black,
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