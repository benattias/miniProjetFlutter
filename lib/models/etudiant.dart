import 'dart:convert';

class Etudiant {
  int?
      id; // Rendez le paramètre id optionnel en ajoutant le ? après le type de données
  String nom;
  String prenom;
  String matricule;

  Etudiant(
      {this.id,
      required this.nom,
      required this.prenom,
      required this.matricule});

  factory Etudiant.fromJson(Map<String, dynamic> json) {
    return Etudiant(
      id: json['id'],
      nom: json['nom'],
      prenom: json['prenom'],
      matricule: json['matricule'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'matricule': matricule,
    };
  }
}
