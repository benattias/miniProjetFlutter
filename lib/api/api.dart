import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/etudiant.dart';

class Api {
  final String baseUrl;

  Api(this.baseUrl);

  Future<List<Etudiant>> fetchEtudiants() async {
    final response = await http.get(Uri.parse('$baseUrl/etudiants'));

    if (response.statusCode == 200) {
      Iterable<dynamic> list = json.decode(response.body);
      return list.map((model) => Etudiant.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load etudiants');
    }
  }

  Future<void> deleteEtudiant(int etudiantId) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/etudiants/$etudiantId'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete etudiant');
    }
  }

  Future<void> ajouterEtudiant(Etudiant etudiant) async {
    final response = await http.post(
      Uri.parse('$baseUrl/etudiants'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(etudiant.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add etudiant');
    }
  }

  Future<void> updateEtudiant(Etudiant etudiant) async {
    final response = await http.put(
      Uri.parse('$baseUrl/etudiants/${etudiant.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(etudiant.toJson()),
    );

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to update etudiant');
    }
  }
}
