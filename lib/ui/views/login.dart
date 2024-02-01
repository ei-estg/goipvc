import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/providers/profile_provider.dart';
import 'package:goipvc/providers/settings_provider.dart';
import 'package:goipvc/providers/shared_preferences_provider.dart';
import 'package:goipvc/services/myipvc_api.dart';
import 'package:goipvc/ui/views/index.dart';
import 'package:goipvc/ui/widgets/goipvc_logo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/sas_api.dart';

class _LoadingNotifier extends StateNotifier<bool> {
  _LoadingNotifier() : super(false);

  void set(bool val) {
    state = val;
  }
}

final _loadingProvider =
    StateNotifierProvider<_LoadingNotifier, bool>((ref) => _LoadingNotifier());

// TODO: improve the state to use an object instead of two instances of state notifiers
class _ValidFields extends StateNotifier<bool> {
  _ValidFields() : super(true);

  void set(bool val) {
    state = val;
  }
}

final _validFieldsProvider =
StateNotifierProvider<_ValidFields, bool>((ref) => _ValidFields());

class LoginView extends ConsumerWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  LoginView({super.key});

  Future<void> _login(BuildContext context, WidgetRef ref) async {
    SharedPreferences prefs = ref.read(sharedPreferencesProvider);
    ref.read(_loadingProvider.notifier).set(true);
    bool isValid = _usernameController.text != '' || _passwordController.text != '';
    ref.read(_validFieldsProvider.notifier).set(isValid);

    if(!isValid) {
      ref.read(_loadingProvider.notifier).set(false);
      return;
    }

    try {
      String? user = await MyIPVCAPI
          .login(_usernameController.text, _passwordController.text);

      SASApiStatus sasAuthSuccess = await SAS
          .login(_usernameController.text, _passwordController.text);

      if(sasAuthSuccess == SASApiStatus.unknownError) {
        throw Exception("Erro a obter token do SAS");
      }

      if (user == null || sasAuthSuccess == SASApiStatus.incorrectCreds) {
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
    bool isValid = ref.watch(_validFieldsProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(64, 0, 64, 8),
              child: GoIPVCLogo(size: 64),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Text(
                "goIPVC não é um projeto oficial do IPVC",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            AutofillGroup(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
                child: SizedBox(
                  width: MediaQuery.of(context).orientation.name == "portrait"
                    ? null
                    : MediaQuery.of(context).size.width/2,
                  child: Column(
                    children: [
                    TextField(
                      focusNode: _usernameFocusNode,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          errorText: !isValid ? "O campo não pode ser vazio" : null,
                          labelText: "Utilizador"),
                      autofillHints: const [AutofillHints.username],
                      controller: _usernameController,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      focusNode: _passwordFocusNode,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          errorText: !isValid ? "O campo não pode ser vazio" : null,
                          labelText: "Palavra-passe"),
                      autofillHints: const [AutofillHints.password],
                      controller: _passwordController,
                      autocorrect: false,
                    ),
                  ],
                  ),
                )
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
