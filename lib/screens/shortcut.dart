// shortcut.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallShortcut extends StatelessWidget {
  final String phoneNumber;

  CallShortcut({required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.phone),
      onPressed: () {
        _launchPhone(phoneNumber);
      },
    );
  }

  void _launchPhone(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir la aplicación de llamadas.';
    }
  }
}
