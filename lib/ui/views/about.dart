import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  Future<void> _launchUrl() async {
    final url = Uri.parse("https://github.com/joaoalves03/goipvc");

    await launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sobre"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/logo.png"),
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text("O goIPVC é uma interface alternativa à aplicação "
                  "oficial do IPVC, \"my ipvc\".")
            ),
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
        ),
      )
    );
  }

}