import 'package:flutter/material.dart';
import '../api/api.dart';
import '../models/etudiant.dart';

class UpdateEtudiantScreen extends StatefulWidget {
  final Etudiant etudiant;

  UpdateEtudiantScreen({required this.etudiant});

  @override
  _UpdateEtudiantScreenState createState() => _UpdateEtudiantScreenState();
}

class _UpdateEtudiantScreenState extends State<UpdateEtudiantScreen> {
  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController matriculeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialiser les contrôleurs avec les valeurs existantes de l'étudiant
    nomController.text = widget.etudiant.nom;
    prenomController.text = widget.etudiant.prenom;
    matriculeController.text = widget.etudiant.matricule;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier l\'étudiant'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Mettez à jour les données de l'étudiant sur le serveur
                updateEtudiant();
              },
              child: Text('Enregistrer les modifications'),
            ),
          ],
        ),
      ),
    );
  }

  void updateEtudiant() async {
    // Vérifiez que les contrôleurs ne sont pas vides
    if (nomController.text.isNotEmpty &&
        prenomController.text.isNotEmpty &&
        matriculeController.text.isNotEmpty) {
      // Créez un objet Etudiant avec les nouvelles valeurs
      Etudiant updatedEtudiant = Etudiant(
        id: widget.etudiant.id,
        nom: nomController.text,
        prenom: prenomController.text,
        matricule: matriculeController.text,
      );

      // Mettez à jour l'étudiant sur le serveur
      final Api api = Api('http://localhost:3000');
      await api.updateEtudiant(updatedEtudiant);

      // Retournez à l'écran précédent
      Navigator.pop(context);
    } else {
      // Affichez un message d'erreur si des champs sont vides
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veuillez remplir tous les champs'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
