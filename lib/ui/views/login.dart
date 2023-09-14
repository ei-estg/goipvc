import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myipvc_budget_flutter/providers/profile_provider.dart';
import 'package:myipvc_budget_flutter/services/myipvc_api.dart';
import 'package:myipvc_budget_flutter/ui/views/index.dart';
import 'package:myipvc_budget_flutter/ui/widgets/ipvc_logo.dart';

class _LoadingNotifier extends StateNotifier<bool> {
  _LoadingNotifier() : super(false);
  void set(bool val) {state = val;}
}

final _loadingProvider = StateNotifierProvider<_LoadingNotifier, bool>(
        (ref) => _LoadingNotifier()
);

class LoginView extends ConsumerWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginView({super.key});

  Future<void> _login(BuildContext context, WidgetRef ref) async {
    ref.read(_loadingProvider.notifier).set(true);
    
    try {
      String? user = await MyIPVCAPI().login(
          _usernameController.text,
          _passwordController.text
      );

      if(user == null) {
        throw Exception("Utilizador/Palavra-Passe incorreto");
      } else {
        ref.read(profileProvider.notifier).set(user);

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

    ref.read(_loadingProvider.notifier).set(false);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool loading = ref.watch(_loadingProvider);

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
              onPressed: loading ? null : () => _login(context,ref),
            ),
          ],
        )
      )
    );
  }

}