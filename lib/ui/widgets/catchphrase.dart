import 'package:flutter/material.dart';

class CatchPhrase extends StatelessWidget {
  const CatchPhrase({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 15,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        children: const <TextSpan>[
          TextSpan(
            text: 'O ',
          ),
          TextSpan(
            text: 'teu',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: '.',
            style: TextStyle(
                fontSize: 80,
                height: 0.1
            ),
          ),
          TextSpan(
            text: 'de partida',
          ),
        ],
      ),
      textAlign: TextAlign.left,
    );
  }

}