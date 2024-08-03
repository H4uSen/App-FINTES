import 'package:app_fintes/widgets/divider.dart';
import 'package:app_fintes/widgets/theme_config.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      
      backgroundColor: CustomColors.lightBlue,
      child: ListView(
        
        children: [
          DrawerHeader(
            decoration:const BoxDecoration(
              color: CustomColors.white,
            ),
            child: Row(
              children: [
                Container(
                  width: 110,
                  height: 110,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/fintes_app.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 130,
                    //TODO: Hacer que agarre el primer nombre del usuario solamente
                    child: Text(
                      'Ermenegildo',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: CustomColors.black,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),


          const CustomDivider(title: 'Cuentas'),
          
          
          Container(
            alignment: Alignment.center,
            width: 100,
            decoration: const BoxDecoration(
              color: CustomColors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              border: Border(
                bottom: BorderSide(
                  color: CustomColors.darkBlue,
                  width: 1,
                ),
              ),
            ),
            child: ListTile(
              title: const Text('Inicio'),
            
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
            ),
          ),
          ListTile(

            title: const Text('Registro'),
            onTap: () {
              Navigator.pushNamed(context, '/registro');
            },
          ),
          ListTile(
            title: const Text('Login'),
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
