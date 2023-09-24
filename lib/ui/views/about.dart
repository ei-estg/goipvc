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
            const GoIPVCLogo(),
            Padding(
              padding: const EdgeInsets.only(top: 16),
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
            const Text("O goIPVC é uma interface alternativa à aplicação "
                "oficial do IPVC, \"my ipvc\"."),
            const Divider(),
            const Text(
              "Aviso legal:",
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.end,
            ),
            const Text(
              "O goIPVC é um projeto independente desenvolvido por estudantes "
              "do IPVC. Não é oficialmente endossado nem afiliado à "
              "instituição. No entanto, todos os logotipos e informações "
              "usados neste aplicativo foram obtidos no site oficial do IPVC "
              "e seguem as diretrizes de marca da instituição."
            ),
            const Padding(padding: EdgeInsets.all(4)),
            const Text(
              "Aviso de Direitos Autorais:",
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.end,
            ),
            const Text(
              "Todos os direitos de conteúdo e propriedade intelectual "
              "relacionados ao IPVC, incluindo logotipos e informações "
              "oficiais, são de propriedade do Instituto Politécnico "
              "de Viana do Castelo."
            ),
            const Padding(padding: EdgeInsets.all(4)),
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