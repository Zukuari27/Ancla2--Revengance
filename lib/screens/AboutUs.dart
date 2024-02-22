import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class AboutUsPage extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0x000000),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                  radius: 70, backgroundImage: AssetImage('assets/anclalogo.jpg')),
              Text(
                'Ancla',
                style: TextStyle(
                    fontFamily: 'Pacifico',
                    color: Color(0xFFFFFFFF),
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Comunidad Parralense',
                style: TextStyle(
                    fontFamily: 'SourceSansPro',
                    letterSpacing: 2.5,
                    color: Color(0xFFFFFFFF),
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                height: 20,
                width: 150,
                child: Divider(
                  color: Color(0xff000000),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 25),
                child: ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Color(0xff000000),
                  ),
                  title: Text(
                    '+292839485738',
                    style: TextStyle(
                      fontFamily: 'SourceSansPro',
                      color: Color(0xff000000),
                      fontSize: 20,
                    ),
                  ),
                ),

              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 2,horizontal: 25),
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Color(0xff000000),
                  ),
                  title: Text(
                    'XXXXXXXXX@gmail.com',
                    style: TextStyle(
                      fontFamily: 'SourceSansPro',
                      color: Color(0xff000000),
                      fontSize: 20,
                    ),
                  ),
                ),

              ),
              SizedBox(
                height: 20,
                width: 150,
                child: Divider(
                  color: Color(0xff000000),
                ),
              ),

              Text(
                '    Apoyanos          Encuentranos',
                style: TextStyle(
                    fontFamily: 'Pacifico',
                    color: Color(0xFFFFFFFF),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              //la fila que va abajo de la info general esta aqui
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [

                  SizedBox(
                    height: 20,
                    width: 20,
                    child: Divider(
                      color: Color(0xff000000),
                    ),
                  ),

                  InkWell(
                    onTap: () async {
                      const url = 'https://paypal.com';  // Replace with the desired external link
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    child: CircleAvatar(
                        radius: 60, backgroundImage: AssetImage('assets/paypallogo2.png')),

                  ),


                  InkWell(
                    onTap: () async {
                      const url = 'https://www.google.com.mx/maps/@26.9502376,-105.7233928,15z?entry=ttu';  // Replace with the desired external link
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    child: CircleAvatar(
                        radius: 60, backgroundImage: AssetImage('assets/gmaps.png')),

                  ),
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: Divider(
                      color: Color(0xff000000),
                    ),
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

