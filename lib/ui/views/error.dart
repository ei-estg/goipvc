import 'package:flutter/material.dart';

class ErrorView extends StatefulWidget {
  final String error;

  const ErrorView({super.key, required this.error});

  @override
  State<ErrorView> createState() => _ErrorViewState();
}

class _ErrorViewState extends State<ErrorView> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.error, size: 48),
            const Text("Ocorreu um erro", style: TextStyle(fontSize: 24)),
            Text(widget.error, textAlign: TextAlign.center)
          ],
        )
    );
  }

}