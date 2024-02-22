import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(ProfileApp());
}

class ProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Perfil'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: ProfileTab(), // Envuelve ProfileTab con Scaffold
      ),
    );
  }
}

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late SharedPreferences _prefs;
  late String _username;
  late String _description;
  late String _email;
  late String _phone;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = _prefs.getString('username') ?? 'Nombre de Usuario';
      _description = _prefs.getString('description') ?? 'Descripción del usuario...';
      _email = _prefs.getString('email') ?? 'correo@example.com';
      _phone = _prefs.getString('phone') ?? '+1234567890';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile_image.jpg'), // Cambia 'assets/profile_image.jpg' por la ruta de tu imagen de perfil
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Nombre de Usuario'),
            subtitle: Text(_username),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _editDetail(context, 'Nombre de Usuario', _username, (value) {
                  setState(() {
                    _username = value;
                  });
                  _prefs.setString('username', value);
                });
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Algo que gustes agregar '),
            subtitle: Text(_description),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _editDetail(context, 'agregar', _description, (value) {
                  setState(() {
                    _description = value;
                  });
                  _prefs.setString('description', value);
                });
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Correo electrónico'),
            subtitle: Text(_email),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _editDetail(context, 'Correo electrónico', _email, (value) {
                  setState(() {
                    _email = value;
                  });
                  _prefs.setString('email', value);
                });
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('Teléfono'),
            subtitle: Text(_phone),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _editDetail(context, 'Teléfono', _phone, (value) {
                  setState(() {
                    _phone = value;
                  });
                  _prefs.setString('phone', value);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  void _editDetail(BuildContext context, String label, String value, Function(String) onSave) {
    TextEditingController _controller = TextEditingController(text: value);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar $label'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Nuevo valor',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                String newValue = _controller.text;
                onSave(newValue); // Actualiza el estado con el nuevo valor
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}