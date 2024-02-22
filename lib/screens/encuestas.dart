import 'package:habo/encuesta/encuesta_ansiedad.dart';
import 'package:habo/encuesta/encuesta_depresion.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main_menu.dart';
import 'AboutUs.dart';
import 'package:table_calendar/table_calendar.dart';

class EncuestaHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Organization Info',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme:
            ColorScheme.dark(background: Color.fromARGB(255, 255, 255, 255)),
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Inicio'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navega a la página de tamizaje
              },
              child: Text(
                'Pre-Tamizaje',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Navega a la página de test de ansiedad
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TestAnsiedad()),
                );
              },
              child: Text(
                'Test de Ansiedad',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Navega a la página de test de depresión
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TestDepresion()),
                );
              },
              child: Text(
                'Test de Depresión',
                style: TextStyle(color: Colors.white),
              ),
            ),
            // Agregar el calendario

            // Eventos del calendario pueden ser manejados aquí
            // Agrega la lógica según tus requerimientos

            // Agregar la tabla de metas
          ],
        ), // Agrega el menú principal
      ),
    );
  }
}
