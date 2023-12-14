import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl;

  AuthService(this.baseUrl);

  Future<bool> signUp(String username, String password) async {
    // Vérifiez si l'utilisateur existe déjà
    final response = await http.put(
      Uri.parse('$baseUrl/users/$username'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'password': password}),
    );

    if (response.statusCode == 200) {
      // L'utilisateur existe déjà, ne pas permettre l'inscription
      return false;
    }

    // Ajoutez le nouvel utilisateur au fichier users.json
    await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'password': password}),
    );

    return true; // Inscription réussie
  }

  Future<bool> signIn(String username, String password) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users?username=$username&password=$password'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> users = json.decode(response.body);

      if (users.isNotEmpty) {
        return true; // Authentification réussie
      }
    }

    return false; // Échec de l'authentification
  }
}
