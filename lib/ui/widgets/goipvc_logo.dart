import 'package:flutter/material.dart';

class GoIPVCLogo<T> extends StatelessWidget {
  const GoIPVCLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        Theme.of(context).colorScheme.onPrimaryContainer,
        BlendMode.srcIn,
      ),
      child: Image.asset(
        (() {
          return 'assets/logo.png';
        })(), // Change this color to match the parts to be filtered
        height: 48,
      ),
    );
  }
}
