import 'package:flutter/material.dart';
import 'package:gestion_etudiants/screens/signup.dart';
import '../api/auth_service.dart';
import 'etudiants_screen.dart';
import 'package:flutter_animator/flutter_animator.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService authService = AuthService('http://localhost:4000');
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  double _fontSize = 20.0; // Taille de police initiale
  double _maxFontSize =
      40.0; // Taille de police maximale pour le caractère ciblé
  Color _textColor = Colors.black; // Couleur de texte initiale
  Color _targetColor = Colors.blue; // Couleur de texte cible

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text('Connexion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlipInY(
              child: Text(
                'Connexion',
                style: TextStyle(
                  fontSize: _fontSize,
                  fontWeight: FontWeight.bold,
                  color: _textColor,
                ),
              ),
            ),
            Slider(
              value: _fontSize,
              min: 20.0,
              max: _maxFontSize,
              onChanged: (value) {
                setState(() {
                  _fontSize = value;
                });
              },
            ),
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Nom d\'utilisateur',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Mot de passe',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String username = usernameController.text;
                String password = passwordController.text;

                bool signinSuccess =
                    await authService.signIn(username, password);
                if (signinSuccess) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EtudiantsScreen()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Échec de la connexion'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text('Se connecter'),
            ),
            SizedBox(height: 16),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
              child: Text(
                'Pas de compte? S\'inscrire ici',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
