import 'package:flutter/material.dart';
import 'package:goipvc/services/myipvc_api.dart';
import 'package:goipvc/ui/views/error.dart';
import 'package:goipvc/ui/views/login.dart';

import '../../services/github.dart';
import '../../services/sas_api.dart';
import '../widgets/goipvc_logo.dart';
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
    checkIfAppWasUpdated();
    MyIPVCAPI.verifyAuth().then((myipvcStatus) {
      SAS.fetchAccessToken().then((sasStatus) {
        if(myipvcStatus == -1 || sasStatus == -1){
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Scaffold(
                body: ErrorView(
                  error: "Erro a estabelecer conexão ao servidor",
                  displayError: true,
                  icon: Icons.wifi_off,
                  callback: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const InitView())
                    );
                  },
                ),
              ))
          );
          return;
        }

        if(myipvcStatus == 0 || sasStatus == 0){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginView()));
          return;
        }

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const IndexView()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(64, 0, 64, 8),
                child: GoIPVCLogo(size: 64),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text(
                  "goIPVC não é um projeto oficial do IPVC",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              CircularProgressIndicator()
            ],
          )
      ),
    );
  }
}