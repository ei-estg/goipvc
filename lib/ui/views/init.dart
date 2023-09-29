import 'package:flutter/material.dart';
import 'package:goipvc/services/myipvc_api.dart';
import 'package:goipvc/ui/views/login.dart';

import '../../services/sas_api.dart';
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
    MyIPVCAPI().verifyAuth().then((myipvc) {
      SAS.fetchAccessToken().then((sas) => {
        Navigator.pushReplacement(
          context,
            // if authenticated in both myipvc or sas
            (myipvc && sas)
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
            children: <Widget>[CircularProgressIndicator()],
          )
      ),
    );
  }
}