import 'package:flutter/material.dart';
import 'package:goipvc/services/myipvc_api.dart';
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
    MyIPVCAPI.verifyAuth().then((myipvc) {
      SAS.fetchAccessToken().then((_) => {
        Navigator.pushReplacement(
          context,
            // check myipvc authentication
            myipvc
            ? MaterialPageRoute(builder: (context) => const IndexView())
            : MaterialPageRoute(builder: (context) => LoginView())
        )
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