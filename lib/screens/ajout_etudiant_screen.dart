import 'package:flutter/material.dart';
import '../api/api.dart';
import '../models/etudiant.dart';

class AjoutEtudiantScreen extends StatefulWidget {
  @override
  _AjoutEtudiantScreenState createState() => _AjoutEtudiantScreenState();
}

class _AjoutEtudiantScreenState extends State<AjoutEtudiantScreen> {
  // Déclarez les contrôleurs pour les champs de formulaire
  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController matriculeController = TextEditingController();
  final Api api = Api('http://localhost:3000');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un étudiant'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // Ajoutez les champs de formulaire pour les détails de l'étudiant
          children: [
            TextField(
              controller: nomController,
              decoration: InputDecoration(labelText: 'Nom'),
            ),
            TextField(
              controller: prenomController,
              decoration: InputDecoration(labelText: 'Prénom'),
            ),
            TextField(
              controller: matriculeController,
              decoration: InputDecoration(labelText: 'Matricule'),
            ),
            SizedBox(
                height:
                    16.0), // Ajoutez un espace entre les champs et le bouton
            ElevatedButton(
              onPressed: () {
                // Récupérez les valeurs des champs de formulaire
                String nom = nomController.text;
                String prenom = prenomController.text;
                String matricule = matriculeController.text;

                // Créez un nouvel objet Etudiant avec ces valeurs
                Etudiant nouvelEtudiant =
                    Etudiant(nom: nom, prenom: prenom, matricule: matricule);

                // Appelez la méthode pour ajouter l'étudiant
                api.ajouterEtudiant(nouvelEtudiant);

                // Naviguez vers l'écran précédent ou effectuez toute autre action nécessaire
                Navigator.pop(context);
              },
              child: Text('Ajouter'),
            ),
          ],
        ),
      ),
    );
  }
}
