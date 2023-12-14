import 'package:flutter/material.dart';
import '../models/etudiant.dart';

class DetailsEtudiantScreen extends StatelessWidget {
  final Etudiant etudiant;

  DetailsEtudiantScreen({required this.etudiant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de l\'étudiant'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nom: ${etudiant.nom}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Prénom: ${etudiant.prenom}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Matricule: ${etudiant.matricule}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // Ajoutez d'autres détails si nécessaire
          ],
        ),
      ),
    );
  }
}
