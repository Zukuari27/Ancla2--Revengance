import 'package:habo/Auth/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthState with ChangeNotifier {
  bool _isAuthenticated = false;
  String? _accessToken;
  String? _userId;

  bool get isAuthenticated => _isAuthenticated;
  String? get accessToken => _accessToken;
  String? get userId => _userId;

  Future<void> login(String email, String password) async {
    final url = Uri.parse('http://192.168.1.66:1337/api/auth/local');

    try {
      final response = await http
          .post(
            url,
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'identifier': email,
              'password': password,
            }),
          )
          .timeout(Duration(seconds: 10));

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Handle successful login
        final Map<String, dynamic> responseData = json.decode(response.body);
        _accessToken = responseData['jwt'];
        final dynamic userIdDynamic = responseData['user']?['id'];

        if (userIdDynamic is int) {
          _userId = userIdDynamic.toString();
          _isAuthenticated = true;

          // Guardar datos en SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('accessToken', _accessToken!);
          prefs.setString('userId', _userId!);

          notifyListeners();
        } else {
          print('Error: userId is not an integer');
        }
      } else if (response.statusCode == 400) {
        // Handle login failure
        // Puedes lanzar una excepción o manejar el error de alguna otra manera.
        throw Exception('Correo o Contraseña Errónea');
      }
    } catch (e) {
      // Handle timeout u otros errores de red
      // Puedes lanzar una excepción o manejar el error de alguna otra manera.
      throw Exception('Tiempo de espera agotado o error en la conexión.');
    }
  }

  Future<void> logout() async {
    // Limpiar datos de SharedPreferences al cerrar sesión
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('accessToken');
    prefs.remove('userId');

    _isAuthenticated = false;
    notifyListeners();
  }

  Future<bool> checkAuthentication() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    final userId = prefs.getString('userId');

    _isAuthenticated = accessToken != null && userId != null;
    notifyListeners();

    return _isAuthenticated;
  }
}
