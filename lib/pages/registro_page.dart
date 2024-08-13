import 'package:app_fintes/business_logic/user_functions.dart';
import 'package:app_fintes/widgets/custom.dart';
import 'package:app_fintes/widgets/scaffoldmsgs.dart';
import 'package:flutter/material.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key});

  @override
  RegistroPageState createState() => RegistroPageState();
}

class RegistroPageState extends State<RegistroPage> {
  final nombreController = TextEditingController();
  final correoController = TextEditingController();
  final contraseniaController = TextEditingController();
  final confirmarcontraseniaController = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool _obscureContrasenia = true;
  bool _obscureConfirmarContrasenia = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registrarse',
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
                      label: 'Nombre',
                      hintText: 'Ingrese su nombre',
                      maxLength: 30,
                      icon: const Icon(Icons.person),
                      controller: nombreController,
                      validator: (valor) {
                        if (valor == null || valor.isEmpty) {
                          return 'El nombre es obligatorio';
                        }
                        if (valor.length < 3) {
                          return 'El nombre debe tener al menos 3 caracteres';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 25),
                    CustomForm(
                      controller: correoController,
                      keyboardType: TextInputType.emailAddress,
                      label: 'Correo',
                      hintText: 'Ingrese su correo',
                      maxLength: 30,
                      icon: const Icon(Icons.email),
                      validator: (valor) {
                        if (valor == null || valor.isEmpty) {
                          return 'El correo es obligatorio';
                        }
                        if ("@".allMatches(valor,0).length > 1) return 'Ingrese un correo válido';
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    CustomForm(
                      validator: (valor) {
                        if (valor == null || valor.isEmpty) {
                          return 'Ingrese una contraseña';
                        }
                        if (valor.length < 6) {
                          return 'La contraseña debe tener al menos 6 caracteres';
                        }
                        return null;
                      },
                      controller: contraseniaController,
                      keyboardType: TextInputType.visiblePassword,
                      label: 'Contraseña',
                      hintText: 'Ingrese una contraseña',
                      icon: const Icon(Icons.password),
                      maxLength: 30,
                      obscureText: _obscureContrasenia, // Añadido
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
                    CustomForm(
                      validator: (valor) {
                        if (valor == null || valor.isEmpty) {
                          return 'Confirme su contraseña';
                        }
                        if (valor != contraseniaController.text) {
                          return 'Las contraseñas no coinciden';
                        }
                        return null;
                      },
                      controller: confirmarcontraseniaController,
                      label: 'Confirmar Contraseña',
                      hintText: 'Confirme su contraseña',
                      maxLength: 30,
                      icon: const Icon(Icons.password),
                      obscureText: _obscureConfirmarContrasenia, // Añadido
                      icon1: IconButton(
                        icon: Icon(
                          _obscureConfirmarContrasenia ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmarContrasenia = !_obscureConfirmarContrasenia;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (!formkey.currentState!.validate()) return;

                        bool isregistered = register(
                          nombreController.text,
                          correoController.text,
                          contraseniaController.text,
                        );
                        if(isregistered){
                          successScaffoldMsg(context, 'Usuario registrado exitosamente');
                          Navigator.pushReplacementNamed(context, '/principal');
                          
                        } else {
                          scaffoldErrorMsg(context, 'El correo ya está registrado');
                        }
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