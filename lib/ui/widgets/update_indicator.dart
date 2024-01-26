import 'package:flutter/material.dart';

class UpdateIndicator extends StatelessWidget {
  const UpdateIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        onTap: () {},
        child: const Badge(
            child: Padding(
                padding: EdgeInsets.all(4),
                child: Icon(
                  Icons.new_releases_sharp,
                  size: 28,
                )
            )
        ),
      )
    );
  }
}