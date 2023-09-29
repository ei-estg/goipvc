import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/providers/profile_provider.dart';
import 'package:goipvc/providers/settings_provider.dart';
import 'package:goipvc/providers/sharedPreferencesProvider.dart';
import 'package:goipvc/services/myipvc_api.dart';
import 'package:goipvc/ui/views/index.dart';
import 'package:goipvc/ui/widgets/ipvc_logo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _LoadingNotifier extends StateNotifier<bool> {
  _LoadingNotifier() : super(false);

  void set(bool val) {
    state = val;
  }
}

final _loadingProvider =
    StateNotifierProvider<_LoadingNotifier, bool>((ref) => _LoadingNotifier());

class LoginView extends ConsumerWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  LoginView({super.key});

  Future<void> _login(BuildContext context, WidgetRef ref) async {
    SharedPreferences prefs = ref.read(sharedPreferencesProvider);
    ref.read(_loadingProvider.notifier).set(true);

    try {
      String? user = await MyIPVCAPI()
          .login(_usernameController.text, _passwordController.text);

      if (user == null) {
        throw Exception("Utilizador/Palavra-Passe incorreto");
      } else {
        ref.read(profileProvider.notifier).set(user);

        if (prefs.getString("theme") == null) {
          ref.read(settingsProvider.notifier).setColorScheme("school");
        }

        if (context.mounted) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const IndexView()));
        }
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString().substring(11)),
            duration:
                const Duration(seconds: 3), // Adjust the duration as needed
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
              padding: const EdgeInsets.fromLTRB(64, 0, 64, 32),
              child: IpvcLogo(),
            ),
            AutofillGroup(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
                child: Column(
                  children: [
                    TextField(
                      focusNode: _usernameFocusNode,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Utilizador"),
                      autofillHints: const [AutofillHints.username],
                      controller: _usernameController,
                      autocorrect: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      focusNode: _passwordFocusNode,
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Palavra-passe"),
                      autofillHints: const [AutofillHints.password],
                      controller: _passwordController,
                      autocorrect: false,
                    ),
                  ],
                ),
              ),
            ),
            FilledButton.icon(
              label: const Text("Entrar"),
              icon: const Icon(Icons.login),
              onPressed: loading ? null : () => _login(context, ref),
              style: ButtonStyle(
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
