// pages/login_page.dart
import 'package:app_fintes/business_logic/data/globals.dart';
import 'package:app_fintes/business_logic/models/user_model.dart' as mdl;
import 'package:app_fintes/business_logic/user_functions.dart';
import 'package:app_fintes/widgets/custom.dart';
import 'package:app_fintes/widgets/form/custom_button.dart';
import 'package:app_fintes/widgets/scaffoldmsgs.dart';
import 'package:app_fintes/widgets/theme_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  void initState() {
    super.initState();
  }

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
                    const SizedBox(height: 50),
                    CustomForm(
                      controller: correoController,
                      keyboardType: TextInputType.emailAddress,
                      label: 'Correo',
                      hintText: 'Ingrese su correo',
                      icon: const Icon(Icons.email),
                      validator: (valor) {
                        if (valor == null || valor.isEmpty) return 'Ingrese su correo';
                        if ("@".allMatches(valor,0).length != 1) return 'Ingrese un correo válido';
                        return null;
                      },
                    ),
                    const SizedBox(height: 50),
                    CustomForm(
                      controller: contraseniaController,
                      keyboardType: TextInputType.visiblePassword,
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
                    const SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () async {
                        if (!formkey.currentState!.validate()) return;

                        await login(correoController.text, contraseniaController.text)
                        .then((value) {
                          if (value != null) {
                            globalUser = value;
                            Navigator.pushReplacementNamed(context, '/home');
                          }else{
                            errorScaffoldMsg(context, 'Correo o contraseña incorrecta');
                            return;
                          }
                        });
                        
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
                    const SizedBox(height: 60),
                    
                    

                    CustomOutlinedButton(
                    label: 'Iniciar sesión con google',
                    backgroundColor: CustomColors.darkBlue,
                    borderColor: CustomColors.darkBlue,
                    onPressed: () async {
                      await signInWithGoogle(correoController.text, contraseniaController.text).then((userCred) async {
                        if (userCred != null) {
                          globalUser = mdl.User(
                            name: userCred.user!.displayName!, 
                            email: userCred.user!.email!,
                            password: userCred.user!.uid,
                            );
                            await getUserByEmail(userCred.user!.email!).then((value)async {
                              if (value != null) {
                                globalUser!.id = value.id;
                                Navigator.pushReplacementNamed(context, '/home');
                              }else{
                                await register(mdl.User(
                                  name: userCred.user!.displayName!, 
                                  email: userCred.user!.email!,  
                                  password: contraseniaController.text)).then((val){
                                    Navigator.pushReplacementNamed(context, '/home');
                                  });
                              }

                            });
                        }else{
                          errorScaffoldMsg(context, 'Error al iniciar sesión con Google');
                          return;
                        }
                      });
                    },
                    )
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


Future<UserCredential?> signInWithGoogle(String email, String password) async{
  try{
      // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      
    } else if (e.code == 'wrong-password') {
    
    }
    return null;
  }
}