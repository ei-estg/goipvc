import 'package:flutter/material.dart';

class InfoView extends StatelessWidget {
  final String message;

  const InfoView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.info, size: 48),
            Text(message, style: const TextStyle(fontSize: 16)),
          ],
        )
    );
  }

}