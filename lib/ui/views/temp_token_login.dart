import 'package:flutter/material.dart';
import 'package:myipvc_budget_flutter/ui/views/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenLoginView extends StatefulWidget {
  const TokenLoginView({super.key});

  @override
  State<TokenLoginView> createState() => _TokenLoginViewState();
}

class _TokenLoginViewState extends State<TokenLoginView> {
  final _tokenController = TextEditingController();

  Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("token", token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(32,0,32,16),
                  child: TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Token"
                    ),
                    controller: _tokenController,
                  ),
                ),
                FilledButton.icon(
                    label: const Text("Entrar"),
                    icon: const Icon(Icons.login),
                    onPressed: () {
                      if(_tokenController.text.isNotEmpty) {
                        setToken(_tokenController.text);
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => const IndexView()));
                      }
                   }
                ),
              ],
            )
        )
    );
  }
}