import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Rutina {
  final dynamic id; // Cambiado a dynamic para manejar String o int
  final String? nombre;
  final String? detalles;
  final String? categoria;

  Rutina(
      {this.id,
      required this.nombre,
      required this.detalles,
      required this.categoria});

  factory Rutina.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'];
    return Rutina(
      id: json['id'],
      nombre: attributes['nombre'] ?? '',
      detalles: attributes['detalles'] ?? '',
      categoria: attributes['categoria'] ?? '',
    );
  }
}

class RutinaFavorita {
  final Rutina rutina;
  final String categoria;

  RutinaFavorita(this.rutina, this.categoria);
}

class ApiService {
  final String baseUrl;
  final String accessToken;

  ApiService({required this.baseUrl, required this.accessToken});

  Future<List<Rutina>> obtenerRutinas() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/rutinas'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('data')) {
          final List<dynamic> rutinasData = data['data'];
          return rutinasData.map((json) {
            final rutina = Rutina.fromJson(json);
            print(rutina);
            return rutina;
          }).toList();
        } else {
          throw Exception('La respuesta de la API no contiene la clave "data"');
        }
      } else {
        throw Exception(
            'Error al obtener rutinas desde la API: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al obtener rutinas: $e');
    }
  }

  Future<void> agregarRutinaFavorita(
      String userId, String rutinaId, String categoria) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/$userId/agregar-rutina-favorita'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({
          'rutinaId': rutinaId,
          'categoria': categoria,
        }),
      );

      if (response.statusCode == 200) {
        print('Rutina agregada a favoritos con éxito');
      } else {
        throw Exception(
            'Error al agregar rutina a favoritos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al agregar rutina a favoritos: $e');
    }
  }

  Future<List<RutinaFavorita>> obtenerRutinasFavoritas(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/$userId/rutinas-favoritas'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> favoritasData = json.decode(response.body);
        return favoritasData.map((json) {
          final rutina = Rutina.fromJson(json['rutina']);
          final categoria = json['categoria'] ?? '';
          return RutinaFavorita(rutina, categoria);
        }).toList();
      } else {
        throw Exception(
            'Error al obtener rutinas favoritas desde la API: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al obtener rutinas favoritas: $e');
    }
  }
}

class RutinasScreen extends StatefulWidget {
  final String accessToken;
  final String userId; // Identificador único del usuario en Strapi

  RutinasScreen({required this.accessToken, required this.userId});

  @override
  _RutinasScreenState createState() =>
      _RutinasScreenState(accessToken: accessToken, userId: userId);
}

class _RutinasScreenState extends State<RutinasScreen> {
  final ApiService apiService;
  List<Rutina> todasLasRutinas = [];
  List<RutinaFavorita> rutinasFavoritas = [];
  String categoriaSeleccionada = 'General';
  final String userId; // Identificador único del usuario en Strapi

  _RutinasScreenState({required String accessToken, required this.userId})
      : apiService = ApiService(
            baseUrl: 'http://192.168.1.66:1337/api', accessToken: accessToken);

  @override
  void initState() {
    super.initState();
    cargarRutinas();
    cargarRutinasFavoritas();
  }

  Future<void> cargarRutinas() async {
    try {
      final rutinas = await apiService.obtenerRutinas();
      setState(() {
        todasLasRutinas = rutinas;
      });
    } catch (e) {
      print('Error al cargar rutinas: $e');
    }
  }

  Future<void> cargarRutinasFavoritas() async {
    try {
      final favoritas = await apiService.obtenerRutinasFavoritas(userId);
      setState(() {
        rutinasFavoritas = favoritas;
      });
    } catch (e) {
      print('Error al cargar rutinas favoritas: $e');
    }
  }

  List<Rutina> obtenerRutinasPorCategoria(String categoria) {
    return todasLasRutinas
        .where((rutina) =>
            categoria == 'General' ? true : rutina.categoria == categoria)
        .toList();
  }

  void actualizarUI() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Rutina> rutinasCategoria =
        obtenerRutinasPorCategoria(categoriaSeleccionada);

    return Scaffold(
      appBar: AppBar(
        title: Text('Rutinas'),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoritosScreen(
                        rutinasFavoritas: rutinasFavoritas,
                        todasLasRutinas: todasLasRutinas,
                        actualizarUI: actualizarUI,
                      ),
                    ),
                  );
                },
              ),
              if (rutinasFavoritas.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      '${rutinasFavoritas.length}',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: categoriaSeleccionada,
              items: [
                'General',
                'Depresión',
                'Ansiedad',
                'Otra Categoría',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  categoriaSeleccionada = newValue!;
                });
              },
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.white),
              underline: Container(
                height: 2,
                color: Colors.white,
              ),
              dropdownColor: Colors.black,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: rutinasCategoria.length,
        itemBuilder: (context, index) {
          final rutina = rutinasCategoria[index];
          return ListTile(
            title: Text(
              rutina.nombre ?? '',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            trailing: IconButton(
              icon: Icon(Icons.favorite),
              color: rutinasFavoritas
                      .any((favorita) => favorita.rutina.id == rutina.id)
                  ? Colors.red
                  : Colors.grey,
              onPressed: () {
                setState(() {
                  if (rutinasFavoritas
                      .any((favorita) => favorita.rutina.id == rutina.id)) {
                    // Rutina ya es favorita, la quitamos de favoritos
                    rutinasFavoritas.removeWhere(
                        (favorita) => favorita.rutina.id == rutina.id);
                  } else {
                    // Rutina no es favorita, la agregamos a favoritos
                    apiService
                        .agregarRutinaFavorita(
                            userId, rutina.id ?? '', categoriaSeleccionada)
                        .then((_) =>
                            cargarRutinasFavoritas()); // Recargamos la lista de favoritos
                  }
                  actualizarUI();
                });
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetallesRutinaScreen(rutina: rutina),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetallesRutinaScreen extends StatelessWidget {
  final Rutina rutina;

  DetallesRutinaScreen({required this.rutina});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          rutina.nombre ?? '',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              rutina.detalles ?? 'Detalles no disponibles',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoritosScreen extends StatefulWidget {
  final List<RutinaFavorita> rutinasFavoritas;
  final List<Rutina> todasLasRutinas;
  final VoidCallback actualizarUI;

  FavoritosScreen(
      {required this.rutinasFavoritas,
      required this.todasLasRutinas,
      required this.actualizarUI});

  @override
  _FavoritosScreenState createState() => _FavoritosScreenState();
}

class _FavoritosScreenState extends State<FavoritosScreen> {
  String categoriaSeleccionada = 'General';

  List<RutinaFavorita> obtenerRutinasPorCategoria(String categoria) {
    return widget.rutinasFavoritas
        .where((favorita) =>
            categoria == 'General' ? true : favorita.categoria == categoria)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    List<RutinaFavorita> rutinasCategoria =
        obtenerRutinasPorCategoria(categoriaSeleccionada);

    return Scaffold(
      appBar: AppBar(
        title: Text('Rutinas Favoritas'),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: categoriaSeleccionada,
              items: [
                'General',
                'Depresión',
                'Ansiedad',
                'Otra Categoría',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  categoriaSeleccionada = newValue!;
                });
              },
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.black),
              underline: Container(
                height: 2,
                color: Colors.white,
              ),
              dropdownColor: Colors.black,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: rutinasCategoria.length,
        itemBuilder: (context, index) {
          final rutinaFavorita = rutinasCategoria[index];
          return ListTile(
            title: Text(
              rutinaFavorita.rutina.nombre ?? '',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetallesRutinaScreen(rutina: rutinaFavorita.rutina),
                ),
              );
            },
            trailing: IconButton(
              icon: Icon(Icons.favorite),
              color: Colors.red,
              onPressed: () {
                setState(() {
                  // Quitar rutina de favoritos
                  widget.rutinasFavoritas.removeWhere((favorita) =>
                      favorita.rutina.id == rutinaFavorita.rutina.id);
                  widget.actualizarUI();
                });
              },
            ),
          );
        },
      ),
    );
  }
}
