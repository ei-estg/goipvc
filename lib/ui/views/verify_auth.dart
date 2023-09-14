import 'package:flutter/material.dart';
import 'package:myipvc_budget_flutter/services/myipvc_api.dart';
import 'package:myipvc_budget_flutter/ui/views/login.dart';

import 'index.dart';

class VerifyAuthView extends StatefulWidget {
  const VerifyAuthView({super.key});

  @override
  State<VerifyAuthView> createState() => _VerifyAuthViewState();
}

class _VerifyAuthViewState extends State<VerifyAuthView> {
  @override
  void initState() {
    super.initState();
    MyIPVCAPI().verifyAuth().then((data) {
      Navigator.pushReplacement(
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