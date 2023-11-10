import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String error;
  final VoidCallback? callback;
  final bool shouldBeLogged;
  final bool displayError;
  final IconData icon;

  const ErrorView({
    super.key,
    required this.error,
    this.callback,
    this.shouldBeLogged = false,
    this.displayError = false,
    this.icon = Icons.error
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 48),
            const Text("Ocorreu um erro", style: TextStyle(fontSize: 24)),
            if(displayError) Text(error, textAlign: TextAlign.center),
            if(callback != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: FilledButton(
                    onPressed: callback,
                    child: const Text("Tentar novamente")
                ),
              )
          ],
        )
    );
  }

}