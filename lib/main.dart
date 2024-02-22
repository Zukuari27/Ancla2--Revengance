import 'package:flutter/material.dart';
import 'package:habo/main3.dart'; // Import Habo page file
import 'package:habo/screens/Rutinas.dart';
import 'package:habo/screens/Tips.dart';
import 'package:habo/screens/Directorio.dart';
import 'package:habo/services/auth_state.dart';
import 'package:provider/provider.dart';
import 'package:habo/Auth/login.dart';

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
      title: 'Your App',
      home: FutureBuilder<bool>(
        future: authState.checkAuthentication(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoginWidget();
          } else {
            return authState.isAuthenticated
                ? MainPage(
                    accessToken: authState.accessToken!,
                    userId: authState.userId!,
                  )
                : LoginWidget();
          }
        },
      ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Define routes for each page
    );
  }
}

class MainPage extends StatefulWidget {
  final String accessToken;
  final String userId;

  MainPage({required this.accessToken, required this.userId});
  @override
  _MainPageState createState() =>
      _MainPageState(accessToken: accessToken, userId: userId);
}

class _MainPageState extends State<MainPage> {
  final String accessToken;
  final String userId;

  _MainPageState({required this.accessToken, required this.userId});
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hola!'),
      ),
      body: _getPage(_selectedIndex), // Get the selected page
      drawer: Drawer(
        // Define your side menu here
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 79, 79, 79),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Rutinas'),
              onTap: () {
                Navigator.pushNamed(context, '/rutinas');
              },
            ),
            ListTile(
              title: Text('Tips'),
              onTap: () {
                Navigator.pushNamed(context, '/tips');
              },
            ),
            ListTile(
              title: Text('Directorio'),
              onTap: () {
                Navigator.pushNamed(context, '/directorio');
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 114, 114, 114),
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return Habo(); // Main page
      case 1:
        return Directorio(); // Placeholder for Search page
      case 2:
        return TipsScreen(
            accessToken: accessToken,
            userId: userId); // Placeholder for Notifications page
      case 3:
        return RutinasScreen(
            accessToken: accessToken,
            userId: userId); // Placeholder for Profile page
      default:
        return SizedBox(); // Return empty container if index is invalid
    }
  }
}
