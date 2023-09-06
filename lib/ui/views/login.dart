import 'package:flutter/material.dart';
import 'package:myipvc_budget_flutter/services/myipvc_api.dart';
import 'package:myipvc_budget_flutter/ui/widgets/ipvc_logo.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(64,0,64,32),
              child: IpvcLogo(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32,0,32,16),
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Utilizador"
                ),
                controller: _usernameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32,0,32,16),
              child: TextField(
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Palavra-passe"
                ),
                controller: _passwordController,
              ),
            ),
            FilledButton.icon(
              label: const Text("Entrar"),
              icon: const Icon(Icons.login),
              onPressed: () {
                MyIPVCAPI().login(
                    _usernameController.text,
                    _passwordController.text
                );
              }
            ),
          ],
        )
      )
    );
  }

}