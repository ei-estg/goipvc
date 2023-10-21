import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/ui/widgets/goipvc_logo.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

final _versionProvider = FutureProvider<String>((ref) async {
  return (await PackageInfo.fromPlatform()).version;
});

class AboutView extends ConsumerWidget {
  const AboutView({super.key});

  Future<void> _launchUrl() async {
    final url = Uri.parse("https://github.com/joaoalves03/goipvc");

    await launchUrl(url);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final version = ref.watch(_versionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sobre"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GoIPVCLogo(size: 48),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  const Text(
                      "Versão: ",
                      style: TextStyle(fontWeight: FontWeight.bold)
                  ),
                  version.when(
                      loading: () => const SizedBox(width: 10, height: 10, child: CircularProgressIndicator()),
                      error: (err, stack) => const Text("?"),
                      data: (version) => Text(version)
                  )
                ],
              ),
            ),
            const Text("O goIPVC é uma interface alternativa à aplicação oficial do IPVC, \"myipvc\", "
                "desenvolvida por estudantes e ex-estudantes do IPVC. Não tem qualquer afiliação "
                "com o Instituto Politécnico de Viana do Castelo."),
            const Divider(),
            const Text(
              "Contactos:",
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.end,
            ),
            const Text(
                "Para entrar em contacto com os desenvolvedores desta "
                "aplicação, por favor visite o nosso repositório Github."
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [TextButton(
                  onPressed: _launchUrl,
                  child: const Text("Ir para o Github ->")
              )],
            )
          ],
        )),
      )
    );
  }

}