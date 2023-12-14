import 'package:flutter/material.dart';
import 'package:gestion_etudiants/screens/DetailsEtudiantScreen%20.dart';
import 'package:gestion_etudiants/screens/UpdateEtudiantScreen%20.dart';
import '../api/api.dart';
import '../models/etudiant.dart';
import 'ajout_etudiant_screen.dart';

class EtudiantsScreen extends StatefulWidget {
  @override
  _EtudiantsScreenState createState() => _EtudiantsScreenState();
}

class _EtudiantsScreenState extends State<EtudiantsScreen> {
  final Api api = Api('http://localhost:3000');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gestion des étudiants',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AjoutEtudiantScreen()),
              );
            },
            child: Text('Ajouter un étudiant'),
          ),
        ],
      ),
      body: FutureBuilder<List<Etudiant>>(
        future: api.fetchEtudiants(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else {
            List<Etudiant> etudiants = snapshot.data!;
            return ListView.builder(
              itemCount: etudiants.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(etudiants[index].id.toString()),
                  onDismissed: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      // Glissement vers la droite (Suppression)
                      await api.deleteEtudiant(etudiants[index].id!);
                      // Rafraîchir la liste d'étudiants après la suppression
                      List<Etudiant> nouvellesDonnees =
                          await api.fetchEtudiants();
                      setState(() {
                        etudiants = nouvellesDonnees;
                      });
                    } else if (direction == DismissDirection.endToStart) {
                      // Glissement vers la gauche (Mise à jour)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UpdateEtudiantScreen(etudiant: etudiants[index]),
                        ),
                      );
                    }
                  },
                  background: Container(
                    color: Colors.red,
                    child: Icon(Icons.delete, color: Colors.white),
                    alignment: Alignment.centerRight,
                  ),
                  secondaryBackground: Container(
                    color: Colors.blue,
                    child: Icon(Icons.edit, color: Colors.white),
                    alignment: Alignment.centerLeft,
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      '${etudiants[index].nom} ${etudiants[index].prenom}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text('Matricule: ${etudiants[index].matricule}'),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      // Code pour gérer le clic sur l'étudiant
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailsEtudiantScreen(etudiant: etudiants[index]),
                        ),
                      );
                    },
                    tileColor: Colors.blue[50],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
