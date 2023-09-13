import 'package:flutter/material.dart';

class CurricularUnitInfoCard<T> extends StatelessWidget {
  final String title;
  final Widget body;

  const CurricularUnitInfoCard({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(title),
          children: [
            body
          ],
        ),
      )
    );
  }
}