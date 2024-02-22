import 'package:flutter/material.dart';

class MentalHealthTracking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seguimiento de Salud Mental'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Text(
            'Registro Diario',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black),
          ),
          SizedBox(height: 10),
          Text(
            'Registra tus sentimientos y emociones diarias',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Acción para abrir el formulario de registro
            },
            child: Text('Registrar Emociones',),
          ),
          SizedBox(height: 20),
          Text(
            'Estadísticas de Salud Mental',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black
          ),),
          SizedBox(height: 10),
          Text(
            'Visualiza tu progreso a lo largo del tiempo',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Acción para ver las estadísticas
            },
            child: Text('Ver Estadísticas'),
          ),
          SizedBox(height: 20),
          // Puedes agregar más secciones, como consejos de salud mental, recursos, etc.
        ],
      ),
    );
  }
}
