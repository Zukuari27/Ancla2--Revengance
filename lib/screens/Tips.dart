import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Tip {
  final dynamic id; // Cambiado a dynamic para manejar String o int
  final String? titulo;
  final String? contenido;
  final String? categoria;

  Tip(
      {this.id,
      required this.titulo,
      required this.contenido,
      required this.categoria});

  factory Tip.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'];
    return Tip(
      id: json['id'],
      titulo: attributes['titulo'] ?? '',
      contenido: attributes['contenido'] ?? '',
      categoria: attributes['categoria'] ?? '',
    );
  }
}

class TipFavorito {
  final Tip tip;
  final String categoria;

  TipFavorito(this.tip, this.categoria);
}

class ApiService {
  final String baseUrl;
  final String accessToken;

  ApiService({required this.baseUrl, required this.accessToken});
  Future<List<Tip>> obtenerTips() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/tips'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('data')) {
          final List<dynamic> tipsData = data['data'];
          return tipsData.map((json) {
            final tip = Tip.fromJson(json);
            print(tip);
            return tip;
          }).toList();
        } else {
          throw Exception('La respuesta de la API no contiene la clave "data"');
        }
      } else {
        throw Exception(
            'Error al obtener tips desde la API: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al obtener tips: $e');
    }
  }

  Future<void> agregarTipFavorito(
      String userId, String tipId, String categoria) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/$userId/agregar-tip-favorito'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({
          'tipId': tipId,
          'categoria': categoria,
        }),
      );

      if (response.statusCode == 200) {
        print('Tip agregado a favoritos con éxito');
      } else {
        throw Exception(
            'Error al agregar tip a favoritos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al agregar tip a favoritos: $e');
    }
  }

  Future<List<TipFavorito>> obtenerTipsFavoritos(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/$userId/tips-favoritos'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> favoritosData = json.decode(response.body);
        return favoritosData.map((json) {
          final tip = Tip.fromJson(json['tip']);
          final categoria = json['categoria'] ?? '';
          return TipFavorito(tip, categoria);
        }).toList();
      } else {
        throw Exception(
            'Error al obtener tips favoritos desde la API: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al obtener tips favoritos: $e');
    }
  }
}

class TipsScreen extends StatefulWidget {
  final String accessToken;
  final String userId; // Identificador único del usuario en Strapi

  TipsScreen({required this.accessToken, required this.userId});

  @override
  _TipsScreenState createState() =>
      _TipsScreenState(accessToken: accessToken, userId: userId);
}

class _TipsScreenState extends State<TipsScreen> {
  final ApiService apiService;
  List<Tip> todosLosTips = [];
  List<TipFavorito> tipsFavoritos = [];
  String categoriaSeleccionada = 'General';
  final String userId; // Identificador único del usuario en Strapi

  _TipsScreenState({required String accessToken, required this.userId})
      : apiService = ApiService(
            baseUrl: 'http://192.168.1.66:1337/api', accessToken: accessToken);

  @override
  void initState() {
    super.initState();
    cargarTips();
    cargarTipsFavoritos();
  }

  Future<void> cargarTips() async {
    try {
      final tips = await apiService.obtenerTips();
      setState(() {
        todosLosTips = tips;
      });
    } catch (e) {
      print('Error al cargar tips: $e');
    }
  }

  Future<void> cargarTipsFavoritos() async {
    try {
      final favoritos = await apiService.obtenerTipsFavoritos(userId);
      setState(() {
        tipsFavoritos = favoritos;
      });
    } catch (e) {
      print('Error al cargar tips favoritos: $e');
    }
  }

  List<Tip> obtenerTipsPorCategoria(String categoria) {
    return todosLosTips
        .where(
            (tip) => categoria == 'General' ? true : tip.categoria == categoria)
        .toList();
  }

  void actualizarUI() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Tip> tipsCategoria = obtenerTipsPorCategoria(categoriaSeleccionada);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tips'),
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
                      builder: (context) => FavoritosTipsScreen(
                        tipsFavoritos: tipsFavoritos,
                        todosLosTips: todosLosTips,
                        actualizarUI: actualizarUI,
                      ),
                    ),
                  );
                },
              ),
              if (tipsFavoritos.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      '${tipsFavoritos.length}',
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
        itemCount: tipsCategoria.length,
        itemBuilder: (context, index) {
          final tip = tipsCategoria[index];
          return ListTile(
            title: Text(
              tip.titulo ?? '',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            trailing: IconButton(
              icon: Icon(Icons.favorite),
              color: tipsFavoritos.any((favorito) => favorito.tip.id == tip.id)
                  ? Colors.red
                  : Colors.grey,
              onPressed: () {
                setState(() {
                  if (tipsFavoritos
                      .any((favorito) => favorito.tip.id == tip.id)) {
                    // Tip ya es favorito, lo quitamos de favoritos
                    tipsFavoritos
                        .removeWhere((favorito) => favorito.tip.id == tip.id);
                  } else {
                    // Tip no es favorito, lo agregamos a favoritos
                    apiService
                        .agregarTipFavorito(
                            userId, tip.id ?? '', categoriaSeleccionada)
                        .then((_) =>
                            cargarTipsFavoritos()); // Recargamos la lista de favoritos
                  }
                  actualizarUI();
                });
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetallesTipScreen(tip: tip),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetallesTipScreen extends StatelessWidget {
  final Tip tip;

  DetallesTipScreen({required this.tip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tip.titulo ?? '',
          style: TextStyle(
              fontSize: 16,
              color: Colors.black), // Cambiar el color del texto a negro
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tip.contenido ?? 'Contenido no disponible',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black), // Cambiar el color del texto a negro
            ),
          ],
        ),
      ),
    );
  }
}

class FavoritosTipsScreen extends StatefulWidget {
  final List<TipFavorito> tipsFavoritos;
  final List<Tip> todosLosTips;
  final VoidCallback actualizarUI;

  FavoritosTipsScreen(
      {required this.tipsFavoritos,
      required this.todosLosTips,
      required this.actualizarUI});

  @override
  _FavoritosTipsScreenState createState() => _FavoritosTipsScreenState();
}

class _FavoritosTipsScreenState extends State<FavoritosTipsScreen> {
  String categoriaSeleccionada = 'General';

  List<TipFavorito> obtenerTipsPorCategoria(String categoria) {
    return widget.tipsFavoritos
        .where((favorito) =>
            categoria == 'General' ? true : favorito.categoria == categoria)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    List<TipFavorito> tipsCategoria =
        obtenerTipsPorCategoria(categoriaSeleccionada);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tips Favoritos'),
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
        itemCount: tipsCategoria.length,
        itemBuilder: (context, index) {
          final tipFavorito = tipsCategoria[index];
          return ListTile(
            title: Text(
              tipFavorito.tip.titulo ?? '',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetallesTipScreen(tip: tipFavorito.tip),
                ),
              );
            },
            trailing: IconButton(
              icon: Icon(Icons.favorite),
              color: Colors.red,
              onPressed: () {
                setState(() {
                  // Quitar tip de favoritos
                  widget.tipsFavoritos.removeWhere(
                      (favorito) => favorito.tip.id == tipFavorito.tip.id);
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
