import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import "package:permission_handler/permission_handler.dart";

class Contact {
  final String name;
  final String phone;
  final String email;
  final String especialidad;
  final String imagePath; // Nuevo campo para la ruta de la imagen

  Contact({
    required this.name,
    required this.phone,
    required this.email,
    required this.especialidad,
    required this.imagePath, // Agregar la ruta de la imagen al constructor
  });
}

final List<Contact> contacts = [
  Contact(
    name: 'Oscar Ezequie Olivares Padilla',
    phone: '6271338324',
    email: 'Oscar@example.com',
    especialidad: 'Hardware',
    imagePath: 'assets/1.jpg', // Ruta de la imagen para el primer contacto
  ),
  Contact(
    name: 'Jesus Armando Oliguin Saenz',
    phone: '6272795213',
    email: 'Armando@example.com',
    especialidad: 'Diseño y Software',
    imagePath: 'assets/4.jpg', // Ruta de la imagen para el primer contacto
  ),
  Contact(
    name: 'Cristian Portillo Garcia',
    phone: '6271057661',
    email: 'Cristian@example.com',
    especialidad: 'Hardware y Software',
    imagePath: 'assets/3.jpg', // Ruta de la imagen para el primer contacto
  ),
  Contact(
    name: 'Ramiro',
    phone: '6271313384',
    email: 'Ramiro@example.com',
    especialidad: 'Documentacion',
    imagePath: 'assets/2.jpg', // Ruta de la imagen para el primer contacto
  ),
];

class ContactDetails extends StatelessWidget {
  final Contact contact;

  ContactDetails({required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de Contacto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                  radius: 100, backgroundImage: AssetImage(contact.imagePath)),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 100), //a el espacio entre los elementos
                  Text(
                    'Nombre: ${contact.name}',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Email: ${contact.email}',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Especialidad: ${contact.especialidad}',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            SizedBox(
              height: 50, // Ajusta este valor para mover el botón hacia arriba
            ),
            Center(
              child: ElevatedButton(
                onPressed: () => _makePhoneCall(contact.phone),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black, // Color del texto del botón
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Bordes del botón
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 30), // Padding interno del botón
                  textStyle: TextStyle(
                    fontSize: 25, // Tamaño del texto del botón
                  ),
                ),
                child: Text('Llamar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _makePhoneCall(String phoneNumber) async {
    final PermissionStatus status = await Permission.phone.request();

    if (status.isGranted) {
      final formattedPhoneNumber = 'tel:$phoneNumber';
      try {
        await launch(formattedPhoneNumber);
      } catch (e) {
        print('Error al intentar realizar la llamada: $e');
      }
    } else {
      // Mostrar un diálogo indicando que se necesita permiso
    }
  }
}

class ContactsList extends StatelessWidget {
  final List<Contact> contacts;

  ContactsList({required this.contacts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final contact = contacts[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(contact.imagePath),
          ), //aqui se cambia imagen del circulo detalles
          title: Text(
            contact.name,
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          subtitle: Text(
            contact.phone,
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContactDetails(contact: contact),
              ),
            );
          },
        );
      },
    );
  }
}

class ContactsDirectory extends StatelessWidget {
  final List<Contact> contacts;

  ContactsDirectory({required this.contacts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Directorio de Contactos'),
      ),
      body: ContactsList(contacts: contacts),
    );
  }
}

class Directorio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Define un tema personalizado para tu aplicación
        scaffoldBackgroundColor: Colors.white, // Color de fondo del Scaffold
      ),
      home: ContactsDirectory(contacts: contacts),
    );
  }
}
