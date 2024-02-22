import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main_menu.dart';


class InicioScreen extends StatelessWidget {
  final String accessToken;
  final String userId;

  InicioScreen({required this.accessToken, required this.userId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.dark(background: Color.fromARGB(255,255,255,255)),
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
      home: OrganizationInfoPage(accessToken: accessToken,userId:userId),
    );
  }
}

class OrganizationInfoPage extends StatelessWidget {

  final String accessToken;
  final String userId;

  OrganizationInfoPage({required this.accessToken, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
                '¿Porqué Ancla?',
                style: GoogleFonts.bebasNeue(
                    textStyle: TextStyle(
                      fontSize:60.0,

                      color:Colors.black,



                    )

                )
            ),
            CircleAvatar(
                radius: 100, backgroundImage: AssetImage('assets/anclalogo.jpg')),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    'El ancla es la representación de estabilidad y también del regreso a tierra después de navegar, representación de la firmeza de carácter o de convicciones, nos sujeta a esas personas que apreciamos la protección y la seguridad.',
                    style: GoogleFonts.nunitoSans(
                        textStyle: TextStyle(
                          fontSize:20.0,

                          color:Colors.black,



                        )
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            SizedBox(height: 35),
            Text(
              'Abajo encontraras nuestro examen de emociones para que te puedas conocer mas!',

              style: GoogleFonts.nunitoSans(
                  textStyle: TextStyle(
                    fontSize:20.0,

                    color:Colors.black,



                  )
              ),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to a different page
              },
              child: Text('Toma nuestro test!', style: TextStyle(
                color: Colors.white, // Cambia el color del texto del contenido a negro
              ),),
            ),
            SizedBox(height: 12),
            CircleAvatar(
                radius: 150, backgroundImage: AssetImage('assets/comunidadparral.jpeg')),
            SizedBox(height: 50),
            Text(
              'Comunidad',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Cambia el color del texto del contenido a negro
              ),
            ),

            SizedBox(height: 20),
            Text(
              'Una comunidad es un grupo en constante transformación y evolución (su tamaño puede variar), que en su interrelación genera un sentido de pertenencia e identidad social, tomando sus integrantes conciencia de sí como grupo y fortaleciéndose como unidad y potencialidad social.',
              style: GoogleFonts.nunitoSans(
                  textStyle: TextStyle(
                    fontSize:20.0,

                    color:Colors.black,



                  )
              ),
              textAlign: TextAlign.center,


            ),

            SizedBox(height: 50),
            CircleAvatar(
                radius: 150, backgroundImage: AssetImage('assets/fondowaos.jpg')),
            SizedBox(height: 50),
            Text(
              'Mision',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Cambia el color del texto del contenido a negro
              ),
            ),

            SizedBox(height: 20),
            Text(
              'Ser un CENTRO en donde se puedan desarrollar e implementar estrategias multidisciplinarias que beneficien y potencien el bienestar integral de las juventudes, generando un sentido de pertenencia e identidad.',
              style: GoogleFonts.nunitoSans(
                  textStyle: TextStyle(
                    fontSize:20.0,

                    color:Colors.black,



                  )
              ),
              textAlign: TextAlign.center,
            ),



            SizedBox(height: 50),
            CircleAvatar(
                radius: 150, backgroundImage: AssetImage('assets/abrazados1.avif')),
            SizedBox(height: 50),
            Text(
              'Vision',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Cambia el color del texto del contenido a negro
              ),
            ),

            SizedBox(height: 20),
            Text(
              'ANCLA es una comunidad de jóvenes que logran ser agentes de cambio por medio de un proceso de formación continua que involuicra el desarrollo humano, económico y formativo, creando una mentalidad de corresponsabilidad y autogestión quepermita ejercer un nuevo liderazgo inclusivo',
              style: GoogleFonts.nunitoSans(
                  textStyle: TextStyle(
                    fontSize:20.0,

                    color:Colors.black,



                  )
              ),
              textAlign: TextAlign.center,
            ),



            SizedBox(height: 50),
            CircleAvatar(
                radius: 150, backgroundImage: AssetImage('assets/abrazados2.avif')),
            SizedBox(height: 50),
            Text(
              'Valores',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Cambia el color del texto del contenido a negro
              ),
            ),

            SizedBox(height: 20),
            Text(
              'Respeto, Inclusión, Equidad, Empoderamiento, Colaboración, Responsabilidad e Integridad',
              style: GoogleFonts.nunitoSans(
                  textStyle: TextStyle(
                    fontSize:20.0,

                    color:Colors.black,



                  )
              ),
              textAlign: TextAlign.center,
            ),

          ],
        ),
      ),
    );
  }
}

