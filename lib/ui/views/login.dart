import 'package:flutter/material.dart';
import 'package:myipvc_budget_flutter/services/myipvc_api.dart';
import 'package:myipvc_budget_flutter/ui/views/index.dart';
import 'package:myipvc_budget_flutter/ui/widgets/ipvc_logo.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  var _loading = false;

  Future<void> _login() async {
    setState(() {
      _loading = true;
    });

    try {
      var status = await MyIPVCAPI().login(
          _usernameController.text,
          _passwordController.text
      );

      if(status == false) {
        throw Exception("Utilizador/Palavra-Passe incorreto");
      } else {
        if(context.mounted) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const IndexView())
          );
        }
      }
    } catch (error) {
      if(context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString().substring(11)),
            duration: const Duration(seconds: 3), // Adjust the duration as needed
          ),
        );
      }
    }

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(64,0,64,32),
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
              onPressed: _loading ? null : () => _login(),
            ),
          ],
        )
      )
    );
  }

}