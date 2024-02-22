import 'package:habo/Auth/login.dart';
import 'package:habo/screens/AboutUs.dart';
import 'package:habo/screens/Ajustes.dart';
import 'package:habo/screens/encuestas.dart';
import 'package:habo/screens/profile.dart';
import 'package:habo/services/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Seguimiento.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Ajustes'),
            onTap: () {
              // Redirige a la pantalla de ajustes sin rutas
              Navigator.of(context).pop(); // Cierra el menú lateral
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Ajustes()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.door_back_door_outlined),
            title: Text('Cerrar Sesion'),
            onTap: () {
              // Obtén la instancia de AuthState y llama al método logout
              Provider.of<AuthState>(context, listen: false).logout();
              // Navega de regreso a la pantalla de inicio de sesión
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginWidget(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Acerca de'),
            onTap: () {
              Navigator.of(context).pop(); // Cierra el menú lateral
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AboutUsPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.checklist),
            title: Text('Encuesta'),
            onTap: () {
              Navigator.of(context).pop(); // Cierra el menú lateral
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EncuestaHome()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Perfil'),
            onTap: () {
              Navigator.of(context).pop(); // Cierra el menú lateral
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ProfileApp()),
              );
            },
          ),
        ],
      ),
    );
  }
}
