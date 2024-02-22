import 'package:habo/screens/AboutUs.dart';
import 'package:habo/screens/Ajustes.dart';
import 'package:habo/screens/Directorio.dart';
import 'package:habo/screens/Rutinas.dart';
import 'package:habo/screens/Tips.dart';
import 'package:habo/screens/pantalla_principal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/Home.dart';
import 'Auth/login.dart';
import 'services/auth_state.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthState()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthState>(context);

    return MaterialApp(
      title: 'Mi Aplicación',
      home: FutureBuilder<bool>(
        future: authState.checkAuthentication(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoginWidget();
          } else {
            return authState.isAuthenticated
                ? InicioScreen(
                    accessToken: authState.accessToken!,
                    userId: authState.userId!,
                  )
                : LoginWidget();
          }
        },
      ),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme:
            ColorScheme.dark(background: Color.fromARGB(255, 255, 255, 255)),
      ),
      darkTheme: ThemeData.dark(),
      routes: {
        '/inicio': (context) => InicioScreen(
            accessToken: authState.accessToken!, userId: authState.userId!),
        '/tips': (context) => TipsScreen(
            accessToken: authState.accessToken!, userId: authState.userId!),
        '/rutinas': (context) => RutinasScreen(
            accessToken: authState.accessToken!, userId: authState.userId!),
        '/directorio': (context) => ContactsDirectory(contacts: contacts),
        '/config': (context) => Ajustes(),
        '/acercade': (context) => AboutUsPage(),
        // Otras rutas aquí...
      },
    );
  }
}
