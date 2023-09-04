import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final Image logo = Image.asset('assets/ipvc.png');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(64,0,64,32),
              child: logo,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(32,0,32,16),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Utilizador"
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(32,0,32,16),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Palavra-passe"
                ),
              ),
            ),
            FilledButton.icon(
              label: const Text("Entrar"),
              icon: const Icon(Icons.login),
              onPressed: () {}
            ),
          ],
        )
      )
    );
  }

}