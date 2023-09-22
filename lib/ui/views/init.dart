import 'package:flutter/material.dart';
import 'package:goipvc/services/github.dart';
import 'package:goipvc/services/myipvc_api.dart';
import 'package:goipvc/ui/views/login.dart';
import 'package:url_launcher/url_launcher.dart';

import 'index.dart';

class InitView extends StatefulWidget {
  const InitView({super.key});

  @override
  State<InitView> createState() => _InitViewState();
}

class _InitViewState extends State<InitView> {
  @override
  void initState() {
    super.initState();
    getNewRelease().then((version) => {
      if(version != null){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Nova versão disponível: $version"),
                TextButton(
                    onPressed: () {
                      launchUrl(Uri.parse("https://github.com/joaoalves03/goipvc/releases/latest"));
                    },
                    child: const Text("Transferir")
                )
              ],
            ),
            duration: const Duration(seconds: 5), // Adjust the duration as needed
          ),
        )
      }
    });

    MyIPVCAPI().verifyAuth().then((data) {
      Navigator.push(
          context,
          data // If user is authenticated (token exists)
            ? MaterialPageRoute(builder: (context) => const IndexView())
            : MaterialPageRoute(builder: (context) => LoginView())
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[CircularProgressIndicator()],
        )
    );
  }
}