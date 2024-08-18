import 'package:app_fintes/widgets/theme_config.dart';
import 'package:flutter/material.dart';


class PrincipalPage extends StatelessWidget {
  const PrincipalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(131, 180, 255, 1), // Color de fondo
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height,
                width: size.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: 350,
                      width: size.width,
                      child: Image.asset(
                        'assets/images/fintes_app.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 50),
                    const Text(
                      'FINTES',
                      style: TextStyle(
                        fontSize: 100,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        color: Colors.black, 
                      ),
                    ),
                    const SizedBox(height: 15),
                    OutlinedButton(
                      onPressed: (){
                          Navigator.pushNamed(context, '/login');
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 10),
                        backgroundColor: CustomColors.white, 
                        side: const BorderSide(color: CustomColors.black, width: 2), 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child:  Text(
                        'Iniciar Sesión'.toUpperCase(),
                        style: const TextStyle(
                          color: CustomColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),
                    OutlinedButton(
                      onPressed: (){
                        Navigator.pushNamed(context, '/registro');
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 65, vertical: 10),
                        backgroundColor: CustomColors.black, 
                        side: const BorderSide(color: CustomColors.black, width: 2), 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child:  Text(
                        'Registrarse'.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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