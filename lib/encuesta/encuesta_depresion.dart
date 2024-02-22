import 'package:flutter/material.dart';
import 'package:habo/screens/home.dart';

class TestDepresion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Encuesta de Depresión',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey, // Color primario
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.white, // Color de fondo de la pantalla
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black), // Color de texto
          bodyText2: TextStyle(color: Colors.black), // Color de texto
        ),
      ),
      home: InstruccionesPage(),
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
              SizedBox(height: 20.0),
              Text(
                'Por favor, lea con atención cada grupo de afirmaciones. A continuación, seleccione cuál de las afirmaciones de cada grupo describe mejor cómo se ha sentido durante esta última semana, incluido el día de hoy. Puede seleccionar una o máximo dos afirmaciones por grupo.',
                style: TextStyle(fontSize: 26),
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EncuestaPage()),
                  );
                },
                child: Text('Comenzar encuesta'),
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
  late List<int> respuestas; // Cambiamos de List.filled a late List<int>

  @override
  void initState() {
    super.initState();
    // Inicializamos la lista de respuestas con un tamaño de 84 y con valores de -1
    respuestas = List<int>.filled(84, -1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Encuesta de Depresión'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildGrupoAfirmaciones(
              0,
              'No me siento triste',
              'Me siento triste.',
              'Me siento triste continuamente y no puedo dejar de estarlo.',
              'Me siento tan triste o tan desgraciado que no puedo soportarlo.'),
          _buildGrupoAfirmaciones(
              1,
              'No me siento especialmente desanimado respecto al futuro',
              'Me siento desanimado respecto al futuro.',
              'Siento que no tengo que esperar nada.',
              'Siento que el futuro es desesperanzador y las cosas no mejorarán.'),
          _buildGrupoAfirmaciones(
              2,
              'No me siento fracasado',
              'Creo que he fracasado más que la mayoría de las personas.',
              'Cuando miro hacia atrás, sólo veo fracaso tras fracaso.',
              'Me siento una persona totalmente fracasada.'),
          _buildGrupoAfirmaciones(
              3,
              'Las cosas me satisfacen tanto como antes',
              'No disfruto de las cosas tanto como antes.',
              'Ya no obtengo una satisfacción auténtica de las cosas.',
              'Estoy insatisfecho o aburrido de todo.'),
          _buildGrupoAfirmaciones(
              4,
              'No me siento especialmente culpable',
              'Me siento culpable en bastantes ocasiones.',
              'Me siento culpable en la mayoría de las ocasiones.',
              'Me siento culpable constantemente.'),
          _buildGrupoAfirmaciones(
              5,
              'No creo que esté siendo castigado',
              'Me siento como si fuese a ser castigado.',
              'Espero ser castigado.',
              'Siento que estoy siendo castigado.'),
          _buildGrupoAfirmaciones(
              6,
              'No estoy decepcionado de mí mismo',
              'Estoy decepcionado de mí mismo.',
              'Me da vergüenza de mí mismo.',
              'Me detesto.'),
          _buildGrupoAfirmaciones(
              7,
              'No me considero peor que cualquier otro',
              'Me autocritico por mis debilidades o por mis errores.',
              'Continuamente me culpo por mis faltas.',
              'Me culpo por todo lo malo que sucede.'),
          _buildGrupoAfirmaciones(
              8,
              'No tengo ningún pensamiento de suicidio',
              'A veces pienso en suicidarme, pero no lo cometería.',
              'Desearía suicidarme.',
              'Me suicidaría si tuviese la oportunidad.'),
          _buildGrupoAfirmaciones(
              9,
              'No lloro más de lo que solía llorar',
              'Ahora lloro más que antes.',
              'Lloro continuamente.',
              'Antes era capaz de llorar, pero ahora no puedo, incluso aunque quiera.'),
          _buildGrupoAfirmaciones(
              10,
              'No estoy más irritado de lo normal en mí',
              'Me molesto o irrito más fácilmente que antes.',
              'Me siento irritado continuamente.',
              'No me irrito absolutamente nada por las cosas que antes solían irritarme.'),
          _buildGrupoAfirmaciones(
              11,
              'No he perdido el interés por los demás',
              'Estoy menos interesado en los demás que antes.',
              'He perdido la mayor parte de mi interés por los demás.',
              'He perdido todo el interés por los demás.'),
          _buildGrupoAfirmaciones(
              12,
              'Tomo decisiones más o menos como siempre he hecho',
              'Evito tomar decisiones más que antes.',
              'Tomar decisiones me resulta mucho más difícil que antes.',
              'Ya me es imposible tomar decisiones.'),
          _buildGrupoAfirmaciones(
              13,
              'No creo tener peor aspecto que antes',
              'Me temo que ahora parezco más viejo o poco atractivo.',
              'Creo que se han producido cambios permanentes en mi aspecto que me hacen parecer poco atractivo.',
              'Creo que tengo un aspecto horrible.'),
          _buildGrupoAfirmaciones(
              14,
              'Trabajo igual que antes',
              'Me cuesta un esfuerzo extra comenzar a hacer algo.',
              'Tengo que obligarme mucho para hacer algo.',
              'No puedo hacer nada en absoluto.'),
          _buildGrupoAfirmaciones(
              15,
              'Duermo tan bien como siempre',
              'No duermo tan bien como antes.',
              'Me despierto una o dos horas antes de lo habitual y me resulta difícil volver a dormir.',
              'Me despierto varias horas antes de lo habitual y no puedo volverme a dormir.'),
          _buildGrupoAfirmaciones(
              16,
              'No me siento más cansado de lo normal',
              'Me canso más fácilmente que antes.',
              'Me canso en cuanto hago cualquier cosa.',
              'Estoy demasiado cansado para hacer nada.'),
          _buildGrupoAfirmaciones(
              17,
              'Mi apetito no ha disminuido',
              'No tengo tan buen apetito como antes.',
              'Ahora tengo mucho menos apetito.',
              'He perdido completamente el apetito.'),
          _buildGrupoAfirmaciones(
              18,
              'Últimamente he perdido poco peso o no he perdido nada',
              'He perdido más de 2 kilos y medio.',
              'He perdido más de 4 kilos.',
              'He perdido más de 7 kilos.'),
          _buildGrupoAfirmaciones(
              19,
              'No estoy preocupado por mi salud más de lo normal',
              'Estoy preocupado por problemas físicos como dolores, molestias, malestar de estómago o estreñimiento.',
              'Estoy preocupado por mis problemas físicos y me resulta difícil pensar algo más.',
              'Estoy tan preocupado por mis problemas físicos que soy incapaz de pensar en cualquier cosa.'),
          _buildGrupoAfirmaciones(
              20,
              'No he observado ningún cambio reciente en mi interés',
              'Estoy menos interesado por el sexo que antes.',
              'Estoy mucho menos interesado por el sexo.',
              'He perdido totalmente mi interés por el sexo.'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Calcular puntaje total
          int totalScore = respuestas.fold(0, (total, respuesta) {
            if (respuesta != -1) {
              return total + respuesta;
            } else {
              return total;
            }
          });

          // Mostrar el resultado
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
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
              );
            },
          );
        },
        child: Icon(Icons.done, color: Colors.black54),
      ),
    );
  }

  Widget _buildGrupoAfirmaciones(int grupoIndex, String afirmacion1,
      String afirmacion2, String afirmacion3, String afirmacion4) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Text(
            'Grupo ${grupoIndex + 1}:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAfirmacion(grupoIndex, 0, afirmacion1),
            _buildAfirmacion(grupoIndex, 1, afirmacion2),
            _buildAfirmacion(grupoIndex, 2, afirmacion3),
            _buildAfirmacion(grupoIndex, 3, afirmacion4),
          ],
        ),
      ],
    );
  }

  Widget _buildAfirmacion(
      int grupoIndex, int afirmacionIndex, String afirmacion) {
    final int respuestaValue = grupoIndex * 4 + afirmacionIndex;
    return Row(
      children: [
        Checkbox(
          value: respuestas[respuestaValue] != -1,
          onChanged: (value) {
            setState(() {
              if (value!) {
                for (int i = 0; i < 4; i++) {
                  if (i != afirmacionIndex) {
                    respuestas[grupoIndex * 4 + i] = -1;
                  }
                }
                respuestas[respuestaValue] =
                    afirmacionIndex; // Usar afirmacionIndex como el valor de la respuesta
              } else {
                respuestas[respuestaValue] = -1;
              }
            });
          },
          activeColor: Colors.black, // Color de fondo al seleccionar
        ),
        Expanded(
          child: Text(
            afirmacion,
            style:
                TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
          ),
        ),
      ],
    );
  }

  String _interpretarResultado(int score) {
    if (score >= 0 && score <= 10) {
      return 'Estos altibajos son considerados normales.';
    } else if (score >= 11 && score <= 16) {
      return 'Leve perturbación del estado de ánimo.';
    } else if (score >= 17 && score <= 20) {
      return 'Estados de depresión intermitentes.';
    } else if (score >= 21 && score <= 30) {
      return 'Depresión moderada.';
    } else if (score >= 31 && score <= 40) {
      return 'Depresión grave.';
    } else {
      return 'Depresión extrema.';
    }
  }
}
