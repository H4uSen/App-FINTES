import 'package:app_fintes/widgets/drawer/divider.dart';
import 'package:app_fintes/widgets/drawer/drawer_navtile.dart';
import 'package:app_fintes/widgets/drawer/setting_navtile.dart';
import 'package:app_fintes/widgets/theme_config.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: CustomColors.lightBlue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DrawerHeader(
            decoration:const BoxDecoration(
              color: CustomColors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/fintes_app.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: SizedBox(
                    //TODO: Hacer que agarre el primer nombre del usuario solamente
                    width: 150,
                    child: Text(
                      'Ermenegildo lopez',
                      maxLines: 2,
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
          
          Expanded(
            child: ListView(
              children: [
                DrawerNavTile(
                  title: 'Inicio', 
                  icon: Icons.home_rounded, 
                  iconBkgColor: CustomColors.white, 
                  onTap: (){},
                ),
                
                //TODO: Hacer que los botones se les ponga una sombra para identificar la pagina actual y añadir la navegación a las otras paginas
                const CustomDivider(title: 'Cuentas'),
                DrawerNavTile(title: 'Cuenta de ahorros', icon: Icons.attach_money_rounded, onTap: (){}, iconBkgColor: CustomColors.green,),
                const CustomDivider(title: 'Vacío', showLines: false),
                //TODO: Agregar un list builder que cree los botones y muestre las cuentas del usuario
                const CustomDivider(title: 'Metas'),
                const CustomDivider(title: 'Vacío', showLines: false),
                
                const CustomDivider(title: 'Pagos recurrentes'),
                const CustomDivider(title: 'Vacío', showLines: false),
                
              ],
            ),
          ),
      
          const SettingNavtile(title: 'Gestionar cuenta',icon: Icons.settings),
          SettingNavtile(
              title: 'Cerrar sesión', 
              icon: Icons.logout_outlined,
              onTap: () => Navigator.pushReplacementNamed(context, '/principal'),
              ),
          
        ],
      ),
      
    );
  }
}

