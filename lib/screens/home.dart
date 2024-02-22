import 'package:habo/screens/pantalla_principal.dart';
import 'package:flutter/material.dart';
import 'main_menu.dart';
import 'package:habo/screens/Directorio.dart';
import 'package:habo/screens/Rutinas.dart';
import 'package:habo/screens/Tips.dart';

class Home extends StatelessWidget {
  final String accessToken;
  final String userId;

  Home({required this.accessToken, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ancla'),
      ),
      drawer: MainMenu(),
      body: MyHomePage(accessToken: accessToken, userId: userId),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String accessToken;
  final String userId;

  MyHomePage({required this.accessToken, required this.userId});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = InicioScreen(
            accessToken: widget.accessToken, userId: widget.userId);
        break;
      case 1:
        page = RutinasScreen(
            accessToken: widget.accessToken, userId: widget.userId);
        break;
      case 2:
        page =
            TipsScreen(accessToken: widget.accessToken, userId: widget.userId);
        break;
      case 3:
        page = ContactsDirectory(contacts: contacts);
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    var mainArea = ColoredBox(
      color: colorScheme.surfaceVariant,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 400),
        child: page,
      ),
    );

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 450) {
            return Column(
              children: [
                Expanded(child: mainArea),
                SafeArea(
                  child: BottomNavigationBar(
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Inicio',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.directions_run),
                        label: 'Rutinas',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.add_task),
                        label: 'Tips',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.contact_phone),
                        label: 'Directorio',
                      ),
                    ],
                    currentIndex: selectedIndex,
                    onTap: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                )
              ],
            );
          } else {
            return Row(
              children: [
                NavigationRail(
                  extended: constraints.maxWidth >= 600,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite),
                      label: Text('Favorites'),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
                Expanded(child: mainArea),
              ],
            );
          }
        },
      ),
    );
  }
}
