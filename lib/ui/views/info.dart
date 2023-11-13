import 'package:flutter/material.dart';

class InfoView extends StatelessWidget {
  final String message;
  final IconData icon;

  const InfoView({
    super.key,
    required this.message,
    this.icon = Icons.info
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 48),
            Text(message, style: const TextStyle(fontSize: 16)),
          ],
        )
    );
  }

}