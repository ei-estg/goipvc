import 'package:flutter/material.dart';

class GoIPVCLogo<T> extends StatelessWidget {
  final double size;

  const GoIPVCLogo({super.key, required this.size});

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
        height: size,
      ),
    );
  }
}
