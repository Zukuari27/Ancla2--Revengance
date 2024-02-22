import 'package:habo/screens/home.dart';
import 'package:flutter/material.dart';

class TestAnsiedad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Encuesta de Ansiedad',
      theme: ThemeData(
        primaryColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          color: Colors
              .grey[200], // Cambiar el color de la barra de navegación a negro
        ),
        scaffoldBackgroundColor:
            Colors.grey[200], // Cambiar el color de fondo a gris claro
        textTheme: TextTheme(
          bodyText1: TextStyle(
              color: Colors
                  .black87), // Cambiar el color del texto del cuerpo a negro
          bodyText2: TextStyle(
              color: Colors
                  .black87), // Cambiar el color del texto del cuerpo a negro
          headline6: TextStyle(
              color: Colors.black), // Cambiar el color del encabezado a negro
        ),
        sliderTheme: SliderThemeData(
          activeTrackColor: Colors
              .black, // Cambiar el color de la barra de seguimiento activa a negro
          thumbColor: Colors
              .black, // Cambiar el color del pulgar del control deslizante a negro
          overlayColor: Colors.black.withOpacity(
              0.3), // Cambiar el color de la superposición a negro con transparencia
          trackHeight: 4.0, // Ajustar el grosor de la barra de seguimiento
          valueIndicatorColor: Colors
              .black, // Cambiar el color del indicador de valor del control deslizante a negro
          valueIndicatorTextStyle: TextStyle(
              color: Colors
                  .white), // Cambiar el color del texto del indicador de valor a blanco
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: Colors.black), // Cambiar el color secundario a negro
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor:
              Colors.black, // Cambiar el color del botón flotante a negro
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors
                .black, // Cambiar el color de fondo del botón elevado a negro
            textStyle: TextStyle(
                color: Colors
                    .white), // Cambiar el color del texto del botón elevado a blanco
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => InstruccionesPage(),
        '/encuesta': (context) => EncuestaPage(),
      },
    );
  }
}

class InstruccionesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instrucciones'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Responda este cuestionario considerando sus dificultades actuales. Considere como referencia las dificultades que ha tenido este último mes. El Inventario de Ansiedad de Beck es una herramienta útil para valorar los síntomas somáticos de ansiedad, tanto en desórdenes de ansiedad como en cuadros depresivos.',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 18),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/encuesta');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors
                      .black, // Cambiar el color de fondo del botón elevado a negro
                ),
                child: Text(
                  'Comenzar Encuesta',
                  style: TextStyle(
                    color: Colors
                        .white, // Cambiar el color del texto del botón a blanco
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EncuestaPage extends StatefulWidget {
  @override
  _EncuestaPageState createState() => _EncuestaPageState();
}

class _EncuestaPageState extends State<EncuestaPage> {
  List<int> respuestas =
      List.filled(21, 0); // Inicializado con 0 en lugar de -1

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Encuesta de Ansiedad'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildPregunta(0, 'Torpe o entumecido'),
          _buildPregunta(1, 'Acalorado'),
          _buildPregunta(2, 'Con temblor en las piernas'),
          _buildPregunta(3, 'Incapaz de relajarse'),
          _buildPregunta(4, 'Con temor a que ocurra lo peor'),
          _buildPregunta(5, 'Mareado, o que se le va la cabeza'),
          _buildPregunta(6, 'Con latidos del corazón fuertes y acelerados'),
          _buildPregunta(7, 'Inestable'),
          _buildPregunta(8, 'Atemorizado o asustado'),
          _buildPregunta(9, 'Nervioso'),
          _buildPregunta(10, 'Con sensación de bloqueo'),
          _buildPregunta(11, 'Con temblores en las manos'),
          _buildPregunta(12, 'Inquieto, inseguro'),
          _buildPregunta(13, 'Con miedo a perder el control'),
          _buildPregunta(14, 'Con sensación de ahogo'),
          _buildPregunta(15, 'Con temor a morir'),
          _buildPregunta(16, 'Con miedo'),
          _buildPregunta(17, 'Con problemas digestivos'),
          _buildPregunta(18, 'Con desvanecimientos'),
          _buildPregunta(19, 'Con rubor facial'),
          _buildPregunta(20, 'Con sudores, fríos o calientes'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Calcular puntaje total
          int totalScore = respuestas.fold(0, (a, b) => a + b);
          // Mostrar el resultado
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return FadeTransition(
                opacity: ModalRoute.of(context)?.animation ??
                    AlwaysStoppedAnimation(1),
                child: AlertDialog(
                  backgroundColor: Colors
                      .white, // Cambiar el color de fondo del AlertDialog a blanco
                  title: Text('Resultado'),
                  content: Text(_interpretarResultado(totalScore)),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.done),
      ),
    );
  }

  Widget _buildPregunta(int index, String pregunta) {
    return ListTile(
      title: Text(pregunta),
      subtitle: Slider(
        value: respuestas[index].toDouble(),
        onChanged: (value) {
          setState(() {
            respuestas[index] = value.round();
          });
        },
        min: 0,
        max: 3,
        divisions: 3,
        label: respuestas[index].toString(),
      ),
    );
  }

  String _interpretarResultado(int score) {
    if (score >= 0 && score <= 21) {
      return 'Ansiedad muy baja';
    } else if (score >= 22 && score <= 35) {
      return 'Ansiedad moderada';
    } else {
      return 'Ansiedad severa';
    }
  }
}
