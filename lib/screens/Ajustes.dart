import 'package:flutter/material.dart';

class Ajustes extends StatelessWidget {
  final List<String> opciones = [
    'Cuentas',
    'Privacidad',
    'Actualizaciones',
    'Notificaciones',
    'Ayuda y Comentarios',
    // Agrega más opciones según sea necesario
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes'),
      ),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Text(
              "Elige alguna de las opciones",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400,
                childAspectRatio: 400 / 80,
              ),
              itemCount: opciones.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildConfigOption(context, opciones[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfigOption(BuildContext context, String title) {
    void _handleOptionSelection(String option) {
      switch (option) {
        case 'Cuentas':
          _navigateToAccounts(context);
          break;
        case 'Privacidad':
          _navigateToPrivacy(context);
          break;
        case 'Actualizaciones':
          _navigateToUpdates(context);
          break;
        case 'Notificaciones':
          _navigateToNotifications(context);
          break;
        case 'Ayuda y Comentarios':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SupportPage()),
          );
          break;
        default:
          print('Acción para la opción: $option');
      }
    }

    return InkWell(
      onTap: () {
        _handleOptionSelection(title);
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.grey[800],
        child: ListTile(
          leading: Icon(
            Icons.settings,
            color: Colors.white,
          ),
          title: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  void _navigateToAccounts(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AccountsPage()),
    );
  }

  void _navigateToPrivacy(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PrivacyPage()),
    );
  }

  void _navigateToUpdates(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UpdatesPage()),
    );
  }

  void _navigateToNotifications(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotificationsPage()),
    );
  }
}

class AccountsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cuentas'),
      ),
      body: Center(
        child: Text('Página de Configuración de Cuentas'),
      ),
    );
  }
}

class PrivacyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacidad'),
      ),
      body: Center(
        child: Text('Página de Configuración de Privacidad'),
      ),
    );
  }
}

class UpdatesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualizaciones'),
      ),
      body: Center(
        child: Text('Página de Configuración de Actualizaciones'),
      ),
    );
  }
}

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notificaciones'),
      ),
      body: Center(
        child: Text('Página de Configuración de Notificaciones'),
      ),
    );
  }
}

class SupportPage extends StatelessWidget {
  final List<String> opciones = [
    'Ponerse en contacto con el Soporte Técnico',
    'Sugerir una Característica',
    'Preguntas Frecuentes',
    // Agrega más opciones según sea necesario
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ayuda y Comentarios'),
      ),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Text(
              "Elige alguna de las opciones",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400,
                childAspectRatio: 400 / 80,
              ),
              itemCount: opciones.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildConfigOption(context, opciones[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfigOption(BuildContext context, String title) {
    void _handleOptionSelection(String option) {
      switch (option) {
        case 'Ponerse en contacto con el Soporte Técnico':
          _navigateToTechnicalSupport(context);
          break;
        case 'Sugerir una Característica':
          _navigateToFeatureSuggestion(context);
          break;
        case 'Preguntas Frecuentes':
          _navigateToFaq(context);
          break;
        default:
          print('Acción para la opción: $option');
      }
    }

    return InkWell(
      onTap: () {
        _handleOptionSelection(title);
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.grey[800],
        child: ListTile(
          leading: Icon(
            Icons.settings,
            color: Colors.white,
          ),
          title: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  void _navigateToTechnicalSupport(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TechnicalSupportPage()),
    );
  }

  void _navigateToFeatureSuggestion(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FeatureSuggestionPage()),
    );
  }

  void _navigateToFaq(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FaqPage()),
    );
  }
}

class TechnicalSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ponerse en contacto con el Soporte Técnico'),
      ),
      body: Center(
        child: Text('Página de Contacto con Soporte Técnico'),
      ),
    );
  }
}

class FeatureSuggestionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sugerir una Característica'),
      ),
      body: Center(
        child: Text('Página de Sugerir Características'),
      ),
    );
  }
}

class FaqPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preguntas Frecuentes'),
      ),
      body: Center(
        child: Text('Página de Preguntas Frecuentes'),
      ),
    );
  }
}
