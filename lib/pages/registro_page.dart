import 'package:app_fintes/widgets/custom.dart';
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
                      label: 'Correo',
                      hintText: 'Ingrese su correo',
                      icon: const Icon(Icons.email),
                      validator: (valor) {
                        if (valor == null || valor.isEmpty) {
                          return 'El correo es obligatorio';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    CustomForm(
                      controller: contraseniaController,
                      label: 'Contraseña',
                      hintText: 'Ingrese una contraseña',
                      icon: const Icon(Icons.password),
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
                      controller: confirmarcontraseniaController,
                      label: 'Confirmar Contraseña',
                      hintText: 'Confirme su contraseña',
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